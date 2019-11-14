//
//  NetworkClient.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import Alamofire
import BrightFutures

enum NetworkRequestError: Error {
    case networkRequestFailed, tokenExpired
}

protocol MockedModelProtocol {
    static var mockedObject: Self { get }
}

protocol NetworkClientProtocol {
    func performRequest<T: Decodable>(route: NetworkRouter, decoder: JSONDecoder) -> Future<T, NetworkRequestError>
}

class NetworkClient: NetworkClientProtocol {

    func performRequest<T: Decodable>(route: NetworkRouter,
                                      decoder: JSONDecoder = JSONDecoder()) -> Future<T, NetworkRequestError> {
        return Future { complete in
            AF.request(route).responseDecodable(decoder: decoder,
                                                completionHandler: { (response: DataResponse<T>) in
                switch response.result {
                case .success(let data):
                    complete(.success(data))
                case .failure:
                    switch response.response?.statusCode {
                    case 401:
                        complete(.failure(.tokenExpired))
                    default:
                        complete(.failure(.networkRequestFailed))
                    }
                }
            })
        }
    }
    
}


struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()

    static var isConnectedToInternet: Bool {
        return self.sharedInstance?.isReachable ?? true
    }

}
