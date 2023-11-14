//
//  NetworkingHelper.swift
//  Travio
//
//  Created by web3406 on 26.10.2023.
//

import Foundation
import Alamofire
import UIKit

class NetworkingHelper{
    static let shared = NetworkingHelper()
    
    typealias CallBack<T:Codable> = (Result<T,Error>)->Void
    
    func fetchData<T: Decodable>(urlRequest: Router, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlRequest).responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    public func uploadImages<T: Codable>(images: [UIImage], url: String, headers: HTTPHeaders, callback: @escaping CallBack<T>) {
        var imageDataArray: [Data] = []
        
        for image in images {
            if let imageData = image.jpegData(compressionQuality: 1) {
                imageDataArray.append(imageData)
            } else {
                //callback(.failure(APIError(statusCode: 500, message: "Invalid Image Data")))
                return
            }
        }
        AF.upload(
            multipartFormData: { multipartFormData in
                for (index, imageData) in imageDataArray.enumerated() {
                    multipartFormData.append(imageData, withName: "file", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                }
            },
            to: url,
            method: .post,
            headers: headers
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

