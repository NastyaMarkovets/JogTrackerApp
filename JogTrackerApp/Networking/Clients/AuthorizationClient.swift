//
//  AuthorizationClient.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import Alamofire
import BrightFutures

protocol AuthorizationClientProtocol {
    func login(uuid: String) -> Future<Response, NetworkRequestError>
}

class AuthorizationClient: NetworkClient, AuthorizationClientProtocol {
    
    func login(uuid: String) -> Future<Response, NetworkRequestError> {
        return performRequest(route: AuthorizationRouter.login(uuid: uuid))
    }

}
