//
//  APIService.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import Moya
/*
 Request Enum List
 */
enum APIService {

}

/*
 Moya Network Layer
 If you don't now how it works -> https://github.com/Moya/Moya
 */
/*
 Uncomment default if you'll add new requests
 */
extension APIService: TargetType {
    
    var baseURL: URL {
        switch self {
        }
        
    }

    var path: String {
        switch self {
        }
    }

    var method: Moya.Method {
        switch self {
        }
    }

    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String:Any] {
        switch self {
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        }
        
    }

    var task: Task {
        switch self {
        }
    }

    var headers: [String : String]? {
        var headers = [
            "Content-type": "application/json"
        ]
    }
}
