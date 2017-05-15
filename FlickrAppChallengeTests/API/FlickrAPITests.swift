//
//  FlickrAPITests.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 05/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Quick
import Nimble
import Moya
import RxSwift
import RxTest

@testable import FlickrAppChallenge

class FlickrAPITests: QuickSpec {
    
    override func spec () {
        
        describe("fetch manager with success") {
            
            //should use a stubbed model instead
            //let provider = MoyaProvider<FlickrAPIService>(stubClosure: MoyaProvider.immediatelyStub)
            let provider = MoyaProvider<FlickrAPIService>()
            
            let manager = FlickrAPIManager(provider: provider);
            
            it("should be able to init a flickr api manager") {
                expect(manager).toNot(beNil())
            }
            
            it("should receive a valid FlickrAPIResponse from Manager") {
                
                let scheduler = TestScheduler(initialClock: 0);
                
                let observable = manager.findByUsername(username: "eyetwist");
                
                let results = scheduler.createObserver(FlickrAPIResponse.self)
                var subscription: Disposable! = nil
                
                scheduler.scheduleAt(50) {
                    subscription = observable.subscribe(results)
                }
                
                scheduler.scheduleAt(100) {
                    subscription.dispose()
                }
                
                scheduler.start()
                
                //these were working a moment ago... 
                expect(results.events[0].value.element?.photos).toNot(beNil())
                expect(results.events[0].value.element?.photos.photo.count).to(equal(100))
            }
        }
    }
}
