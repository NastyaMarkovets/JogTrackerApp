//
//  NetworkRouter.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Alamofire

struct Server {
    struct Production {
        static let baseURL = "https://jogtracker.herokuapp.com/api/v1"
    }
    
    struct PathComponent {
        static let auth = "auth/uuidLogin"
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accept = "Accept"
    case authorizationToken = "Authorization"
}

enum ContentType: String {
    case formUrlencoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

protocol NetworkRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}


extension NetworkRouter {

    func asURLRequest() throws -> URLRequest {
        let url = try Server.Production.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.formUrlencoded.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
            
        return urlRequest
    }
}
