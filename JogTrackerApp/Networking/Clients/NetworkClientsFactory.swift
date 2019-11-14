//
//  NetworkClientsFactory.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

class NetworkClientsFactory {

    static let shared = NetworkClientsFactory()

    lazy var authorizationClient: AuthorizationClientProtocol = AuthorizationClient()
}
