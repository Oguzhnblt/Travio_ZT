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
    case refresh(params: Parameters)
    case upload(image: Data)
    case profile
    case editProfile(params: Parameters)
    case changePassword(params: Parameters)
    case postPlace(params: Parameters)
    case updatePlace(placeId: String, params: Parameters)
    case deletePlace(placeId: String)
    case getAllPlaces
    case getPlaceById(placeId: String)
    case getAllPlacesForUser
    case getPopularPlaces(limit: Int)
    case getLastPlaces(limit: Int)
    case postGalleryImage(params: Parameters)
    case deleteGalleryImage(placeId: String, imageId: String)
    case getAllGalleryByPlaceId(placeId: String)
    case postVisit(params: Parameters)
    case getAllVisits
    case getVisitById(visitId: String)
    case deleteVisitByPlaceId(placeId: String)
    case checkVisitByPlaceId(placeId: String)
    

        var baseURL:String {
            return "https://api.iosclass.live"
        }
        
        var path:String {
            switch self {
            case .register:
                return "/v1/auth/register"
            case .login:
                return "/v1/auth/login"
            case .refresh:
                return "/v1/auth/refresh"
            case .upload:
                return "/upload"
            case .profile:
                return "/v1/me"
            case .editProfile:
                return "/v1/edit-profile"
            case .changePassword:
                return "/v1/change-password"
            case .postPlace:
                return "/v1/places"
            case .updatePlace(let placeId, _):
                return "/v1/places/\(placeId)"
            case .deletePlace(let placeId):
                return "/v1/places/\(placeId)"
            case .getAllPlaces:
                    return "/v1/places"
            case .getPlaceById(let placeId):
                    return "/v1/places/\(placeId)"
            case .getAllPlacesForUser:
                    return "/v1/places/user"
            case .getPopularPlaces:
                 return "/v1/places/popular"
            case .getLastPlaces:
                return "/v1/places/last"
            case .postGalleryImage:
                return "/v1/galleries"
            case .deleteGalleryImage(let placeId, let imageId):
                return "/v1/galleries/\(placeId)/\(imageId)"
            case .getAllGalleryByPlaceId(let placeId):
                return "/v1/galleries/\(placeId)"
            case .postVisit:
                return "/v1/visits"
            case .getAllVisits:
                return "/v1/visits"
            case .getVisitById(let visitId):
                return "/v1/visits/\(visitId)"
            case .deleteVisitByPlaceId(let placeId):
                return "/v1/visits/\(placeId)"
            case .checkVisitByPlaceId(let placeId):
                return "/v1/visits/user/\(placeId)"
                
                
                
                
            }
        }
        
        
        var method:HTTPMethod {
            switch self {
            case .register, .login, .refresh, .upload, .postPlace, .postGalleryImage, .postVisit:
                return .post
            case .profile, .getAllPlaces, .getPlaceById, .getAllPlacesForUser, .getPopularPlaces, .getAllVisits,.getVisitById, .getLastPlaces, .getAllGalleryByPlaceId:
                return .get
            case .editProfile, .changePassword, .updatePlace:
                return .put
            case .deletePlace, .deleteGalleryImage, .deleteVisitByPlaceId,.checkVisitByPlaceId:
                return .delete
                
            }
        }
        
        
        var headers:HTTPHeaders {
            switch self {
            case .register, .login, .refresh, .upload, .getPlaceById, .getPopularPlaces, .getLastPlaces, .getAllGalleryByPlaceId:
                return [:]
            case .profile, .editProfile, .changePassword, .postPlace, .updatePlace, .deletePlace, .getAllPlaces, .getAllPlacesForUser, .postGalleryImage, .deleteGalleryImage, .postVisit, .getAllVisits, .getVisitById,.deleteVisitByPlaceId,.checkVisitByPlaceId:
                return["Authorization": "Bearer access_token"]
            }
        }
        
        var parameters:Parameters? {
            switch self {
            case .register(let params):
                return params
            case .login(let params):
                return params
            case .refresh(let params):
                return params
            case .upload(let image):
                return nil
            case .profile, .deletePlace, .getAllPlaces, .getPlaceById, .getAllPlacesForUser,.deleteGalleryImage, .getAllGalleryByPlaceId, .getAllVisits, .getVisitById,.deleteVisitByPlaceId,.checkVisitByPlaceId:
                return nil
            case .editProfile(let params):
                return params
            case .changePassword(let params):
                return params
            case .postPlace(let params):
                return params
            case .updatePlace(_ , let params):
                return params
            case .postGalleryImage(let params):
                return params
            case .getPopularPlaces(limit: let limit):
                        let limited = min(limit, 20)
                        return ["limit": limited]
            case .getLastPlaces(limit: let limit):
                        let limited = min(limit, 20)
                        return ["limit": limited]
            case .postVisit(let params):
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
                case .post, .put, .delete :
                    return JSONEncoding.default
                default:
                    return URLEncoding.default
                }
            }()
            
            return try encoding.encode(urlRequest, with: parameters)
        }
        
        
        
}

