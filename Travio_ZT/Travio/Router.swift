//
//  Router.swift
//  Travio
//
//  Created by web3406 on 25.10.2023.
//

import Foundation
import Alamofire

enum Router{
    case register(params:Parameters)
    case login(params: Parameters)
        
        var baseURL:String {
            return "https://api.iosclass.live"
        }
        
        var path:String {
            switch self {
            case .register:
                return "/v1/auth/register"
            case .login:
                return "/v1/auth/login"
            }
        }
        
        
        var method:HTTPMethod {
            switch self {
            case .register, .login:
                return .post
            }
        }
        
        
        var headers:HTTPHeaders {
            switch self {
            case .register, .login:
                return [:]
            }
        }
        
        var parameters:Parameters? {
            switch self {
            case .register(let params):
                return params
            case .login(let params):
                return params
            }
        }
        
        
    }

    extension Router:URLRequestConvertible {
        
        func asURLRequest() throws -> URLRequest {
            let url = try baseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            urlRequest.headers = headers
            
            let encoding:ParameterEncoding = {
                switch method {
                case .post:
                    return JSONEncoding.default
                default:
                    return URLEncoding.default
                }
            }()
            
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        
        
}
