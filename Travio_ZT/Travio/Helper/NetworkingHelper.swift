//
//  NetworkingHelper.swift
//  Travio
//
//  Created by web3406 on 26.10.2023.
//

import Foundation
import Alamofire
import UIKit
import SystemConfiguration

class Reachability {
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
}

class NetworkingHelper{
    
    static let shared = NetworkingHelper()
    
    typealias CallBack<T:Codable> = (Result<T,Error>)->Void
    
    func fetchData<T: Decodable>(urlRequest: Router, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlRequest).responseDecodable(of: T.self) { response in
            if Reachability.isConnectedToNetwork() {
                switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                }
            } else {
                let error = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil)
                completion(.failure(error))
            }
        }
    }
    
    public func imageToURLs<T: Codable>(images: [UIImage], urlRequest: Router, callback: @escaping CallBack<T>) {
        var imageDataArray: [Data] = []
        
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 1) else {continue}
            imageDataArray.append(imageData)
        }
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (index, imageData) in imageDataArray.enumerated() {
                    multipartFormData.append(imageData, withName: "file", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            },
            to: urlRequest.baseURL + urlRequest.path,
            method: urlRequest.method,
            headers: urlRequest.headers
        ).responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let success):
                    callback(.success(success))
                case .failure(let error):
                    callback(.failure(error))
            }
        }
    }
    
}
