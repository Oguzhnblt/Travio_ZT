

import Foundation

struct GetPlaceByIdData: Codable {
           var place: Place?
       }
struct GetPlaceByIdResponse: Codable {
       var data: GetPlaceByIdData?
       var status: String?
}


