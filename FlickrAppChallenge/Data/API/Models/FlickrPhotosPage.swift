//
//  FlickrPhotosPage.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import ObjectMapper

struct FlickrPhotosPage {
    var page: Int = 0
    var pages: Int = 0
    var perpage: Int = 0
    var total: String = ""
    var photo: [FlickrPhoto] = []
}

extension FlickrPhotosPage: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        pages <- map["pages"]
        perpage <- map["perpage"]
        total <- map["total"]
        photo <- map["photo"]
    }
}
