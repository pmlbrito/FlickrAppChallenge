//
//  PhotosListProcess.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 04/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotosListProcessProtocol {
    func fetchUserPhotos() -> Observable<[FlickrPhoto]>
}

class PhotosListProcess: PhotosListProcessProtocol {

    var manager: FlickrAPIManagerProtocol!
    
    init(manager: FlickrAPIManagerProtocol){
        self.manager = manager
    }
    
    func fetchUserPhotos() -> Observable<[FlickrPhoto]> {
        if  let infoPlist = Bundle.main.infoDictionary, let defaultUserForSearch = infoPlist["FlickrAPISearchUser"] as? String {
            return manager.findByUsername(username: defaultUserForSearch).flatMap { apiresponse -> Observable<[FlickrPhoto]> in
                
                return Observable.just(apiresponse.photos.photo)
            }
        }
        return Observable.just([])
    }
}
