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
}
