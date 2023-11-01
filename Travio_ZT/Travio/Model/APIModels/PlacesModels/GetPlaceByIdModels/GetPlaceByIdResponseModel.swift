

import Foundation

struct GetPlaceByIdResponse: Codable {
    struct Data: Codable {
           var place: Place?
       }

       var data: Data?
       var status: String?
}


