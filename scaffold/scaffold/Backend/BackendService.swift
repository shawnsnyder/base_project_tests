//
//  BackendService.swift
//  scaffold
//
//  Created by Shawn Snyder on 2/22/18.
//  Copyright © 2018 YourTrainer. All rights reserved.
//

import Foundation
import Moya

enum BackendService {
    case user
    case updateUser
    case createUser
    case deleteUser
     var stubDataFilename:String{
        let filename = "StreamList"
        return filename
    }
}
extension BackendService : TargetType {
    var path: String {
        switch self {
            case .user : return "/user"
            default: return "/asdf"
        }
    }
    
    var method: Method {
        var method: Moya.Method {
            switch self {
            case .createUser:
                return .post
            case .updateUser:
                return .put
            case .deleteUser:
                return .delete
                
            default:
                return .get
            }
        }
    }
    
    var sampleData: Data {
        return try! Go24StubDataProvider.sharedInstance.stubData(forService:self)

    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string:Constants.Backend.backendURL)!
    }


struct MoyaBackend{
    var provider : MoyaProvider<BackendService>
    init(provider: MoyaProvider<BackendService>){
        self.provider = provider
    }
}
