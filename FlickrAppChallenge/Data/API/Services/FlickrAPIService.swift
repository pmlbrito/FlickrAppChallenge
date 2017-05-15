//
//  FlickrAPIService.swift
//  FlickrAppChallenge
//
//  Created by Pedro Brito on 03/02/2017.
//  Copyright © 2017 Pedro Brito. All rights reserved.
//

import Foundation
import Moya

enum FlickrAPIService {
    case findByUserName(username: String)
}

extension FlickrAPIService: TargetType {
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .findByUserName(_):
            return  URLEncoding()
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest/")!
    }
    
    var path: String {
        /*switch self {
        case .findByUserName(_):
            return "?&method=flickr.photos.search"
        }*/
        return ""
    }
    
    var method: Moya.Method {
        switch self {
        case .findByUserName(_):
            return .get
        }
    }

    
    var parameters: [String: Any]? {
        var requestParams:[String: Any] = [:]
        
        if  let infoPlist = Bundle.main.infoDictionary, let api_key = infoPlist["FlickrAPIKey"] as? String {
            requestParams.updateValue(api_key, forKey: "api_key")
        }
        requestParams.updateValue("json", forKey: "format")
        requestParams.updateValue("1", forKey: "nojsoncallback")

        switch self {
            case .findByUserName(let username):
                requestParams.updateValue("flickr.photos.search", forKey: "method")
            requestParams.updateValue(username, forKey: "username")
        }
        
        return requestParams
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
//        case .findByUserName:
//            return stubbedResponse("api_configuration_response");
        default:
            return Data()
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}
