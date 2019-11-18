//
//  AuthorizationClient.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import BrightFutures

protocol AuthorizationClientProtocol {
    func authorize(uuid: String) -> Future<User, NetworkRequestError>
}

class AuthorizationClient: NetworkClient, AuthorizationClientProtocol {
    
    func authorize(uuid: String) -> Future<User, NetworkRequestError> {
        return performRequest(route: JogsApi.authorize(uuid: uuid))
    }

}
