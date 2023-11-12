//
//  NetworkingHelper.swift
//  Travio
//
//  Created by web3406 on 26.10.2023.
//

import Foundation
import Alamofire

class NetworkingHelper{
    static let shared = NetworkingHelper()
    typealias CallBack<T:Codable> = (Result<T,Error>)->Void
    
    public func fetchData<T: Codable>(urlRequest: Router, callback: @escaping CallBack<T>) {
        AF.request(urlRequest).validate().responseDecodable {(response: DataResponse<T, AFError>)in
            switch response.result {
                case .success(let value):
                    callback(.success(value))
                case .failure(let error):
                    callback(.failure(error))
            }
        }
    }
}
