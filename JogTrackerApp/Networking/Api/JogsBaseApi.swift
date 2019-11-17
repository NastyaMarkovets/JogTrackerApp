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
        static let baseURL = "https://jogtracker.herokuapp.com/api/v1/"
    }
    
    struct PathComponent {
        static let auth = "auth/uuidLogin"
        static let jog = "data/jog"
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

protocol JogsBaseApi: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var queryParameters: [String: String]? { get }
}


extension JogsBaseApi {

    func asURLRequest() throws -> URLRequest {
        let baseUrl = Server.Production.baseURL.appending(path)
        
        var urlComponents = URLComponents(string: baseUrl)
        var queryItems: [URLQueryItem] = []
        queryParameters?.forEach { parameter in
            let queryItem = URLQueryItem(name: parameter.key, value: parameter.value)
            queryItems.append(queryItem)
        }
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        var urlRequest = URLRequest(url: url)
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
