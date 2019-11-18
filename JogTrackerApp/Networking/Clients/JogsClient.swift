//
//  JogsClient.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import BrightFutures

protocol JogsClientProtocol {
    func addNewJog(jog: Jog) -> Future<Jog, NetworkRequestError>
    func getExistingJogs() -> Future<JogsList, NetworkRequestError>
}

class JogsClient: NetworkClient, JogsClientProtocol {
    func addNewJog(jog: Jog) -> Future<Jog, NetworkRequestError> {
        return performRequest(route: JogsApi.addNewJog(jog: jog))
    }
    
    func getExistingJogs() -> Future<JogsList, NetworkRequestError> {
        return performRequest(route: JogsApi.syncJogs)
    }
}
