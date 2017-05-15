//
//  FlickrAPIResponse.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import ObjectMapper

struct FlickrAPIResponse {
    var photos: FlickrPhotosPage = FlickrPhotosPage()
    var stat: String = "ok"

}

extension FlickrAPIResponse: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        photos <- map["photos"]
        stat <- map["stat"]
    }
}
