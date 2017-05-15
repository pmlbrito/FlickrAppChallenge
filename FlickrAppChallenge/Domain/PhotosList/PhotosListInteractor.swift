//
//  PhotosListInteractor.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 04/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotosListInteractorProtocol {
    func fetchUserPhotos() -> Observable<[FlickrPhoto]>
}

class PhotosListInteractor: PhotosListInteractorProtocol {

    var process: PhotosListProcessProtocol!
    
    init(process: PhotosListProcessProtocol) {
        self.process = process
    }
    
    //this would be where we would convert objects fetched from api to DTOs to presentation layer
    func fetchUserPhotos() -> Observable<[FlickrPhoto]> {
        /*return (process.fetchUserPhotos()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .flatMap { result -> Observable<[FlickrPhoto]> in {
                self.convert(result: result)
                }()
            }
            .observeOn(MainScheduler.instance))*/
        return process.fetchUserPhotos()
    }
}
