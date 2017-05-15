//
//  SwinjectStoryboard.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import SwinjectStoryboard
import Swinject
import Moya

extension SwinjectStoryboard {
    
    class func setup() {
        //MARK: - UI
        defaultContainer.storyboardInitCompleted(UISplitViewController.self) { r, c in
            //c.animal = r.resolve(Animal.self)
        }
        
        /*let bundle = bundle(for: SwinjectStoryboard.self)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: bundle, container: defaultContainer)
        let photosListController = storyboard.instantiateViewController(withIdentifier: "PhotosListTableViewController")*/
        
        /*defaultContainer.register(PhotosListTableViewController.self) { r in
            let storyboard =  SwinjectStoryboard.create(name: "Main", bundle: nil, container: defaultContainer)
            let vc = storyboard.instantiateViewController(withIdentifier: "PhotosListTableViewController") as! PhotosListTableViewController
            vc.photosListPresenter = r.resolve(PhotosListPresenterProtocol.self)
            return vc
        }*/
        
        defaultContainer.register(PhotosListProcessProtocol.self) { r in
            PhotosListProcess(manager: r.resolve(FlickrAPIManagerProtocol.self)!)
        }
        
        defaultContainer.register(PhotosListInteractorProtocol.self) { r in
            PhotosListInteractor(process: r.resolve(PhotosListProcessProtocol.self)!)
        }
        
        defaultContainer.register(PhotosListPresenterProtocol.self) { r in
            PhotosListPresenter(interactor: r.resolve(PhotosListInteractorProtocol.self)!)
        }
        
        //MARK: - API
        defaultContainer.register(MoyaProvider<FlickrAPIService>.self) { _ in
            MoyaProvider<FlickrAPIService>()
        }
        
        defaultContainer.register(FlickrAPIManagerProtocol.self) { r in
            FlickrAPIManager(provider: r.resolve(MoyaProvider<FlickrAPIService>.self)!);
        }
    }
    
    static func getResolver() -> Container {
        return defaultContainer;
    }
    
    func storyboard() -> SwinjectStoryboard {
        return SwinjectStoryboard.create(name: "Main", bundle: Bundle.main, container: SwinjectStoryboard.getResolver())
    }
    
    
}
