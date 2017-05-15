//
//  PhotosListPresenter.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 04/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotosListPresenterProtocol {
    func bindView(view: PhotosListTableViewProtocol)
    
    func getDefaultUserPhotos()
}


class PhotosListPresenter: PhotosListPresenterProtocol {
    var view: PhotosListTableViewProtocol!
    
    var interactor: PhotosListInteractorProtocol!
    var isMakingRequest: Bool = false
    var disposeBag = DisposeBag()
    var subscription: Disposable!
    
    init(interactor: PhotosListInteractorProtocol){
        self.interactor = interactor
    }
    
    func bindView(view: PhotosListTableViewProtocol) {
        self.view = view as PhotosListTableViewProtocol
    }
    
    func getDefaultUserPhotos() {
        if isMakingRequest {
            return
        }
        
        (self.view as! UIViewController).showLoadingOverlay()
        
        self.interactor.fetchUserPhotos().subscribe { event -> Void in
            switch event {
            case .next(let response):
                //treat response
                self.view.bindDataFetchResults(photos: response)
                break
            case .error(let error):
                (self.view as! UIViewController).showError(error: error)
                break
            default:
                break
            }
            (self.view as! UIViewController).hideLoadingOverlay()
        }.addDisposableTo(disposeBag)
    }
}
