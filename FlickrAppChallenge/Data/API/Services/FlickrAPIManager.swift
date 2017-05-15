//
//  FlickrAPIManager.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import Moya_ObjectMapper

protocol FlickrAPIManagerProtocol {
    func findByUsername(username: String) -> Observable<FlickrAPIResponse>
}

struct FlickrAPIManager : FlickrAPIManagerProtocol {
    let provider: MoyaProvider<FlickrAPIService>
    
    init(provider: MoyaProvider<FlickrAPIService>) {
        self.provider = provider
    }
}

extension FlickrAPIManager {
    
    fileprivate func requestUserPhotos(_ token: FlickrAPIService) -> Observable<FlickrAPIResponse> {
        
        return Observable.create { observer in
            let disposable = self.provider.request(token) { result in
                switch result {
                case let .success(response):
                    do{
                        let object : FlickrAPIResponse = try response.mapObject(FlickrAPIResponse.self)
                        observer.onNext(object)
                        observer.onCompleted()
                    }catch{
                        observer.onError(error)
                    }
                    
                    break
                case let .failure(error):
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create {
                disposable.cancel()
            }
        }
    }
}

extension FlickrAPIManager {
    func findByUsername(username: String) -> Observable<FlickrAPIResponse> {
        return requestUserPhotos(.findByUserName(username: username))
    }
    
/*    public func bundleVersion() -> Observable<AppVersion> {
        let bundleVersion = requestObject(.appversions()).flatMap { result -> Observable<AppVersion> in
            self.convert(result: result)
        }
        
        return bundleVersion
    }
    
    fileprivate func convert(result: VersionsApiResponse) -> Observable<AppVersion> {
        
        let bundleVersion = Bundle.applicationVersionNumber
        var foundVersion = AppVersion(version_number: bundleVersion, version_status: .current, version_message: "Unable to match version") //setup default
        for version in result.platform.versions {
            if version.version_number == bundleVersion {
                foundVersion = version
                break
            }
        }
        
        return Observable.just(foundVersion)
    }
 */
}
