//
//  FlickrPhoto.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import ObjectMapper

struct FlickrPhoto {
    var id: String = ""
    var owner: String = ""
    var secret: String = ""
    var server: String = ""
    var farm: Int = 0
    var title: String = ""
    var ispublic: Bool = true
    var isfriend: Bool = false
    var isfamily: Bool = false
    
    var photoUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
    
    var largePhotoUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_c.jpg")!
    }
}

extension FlickrPhoto: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        owner <- map["owner"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
        ispublic <- map["ispublic"]
        isfriend <- map["isfriend"]
        isfamily <- map["isfamily"]
    }
}
