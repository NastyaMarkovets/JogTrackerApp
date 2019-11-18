//
//  AuthorizationViewModel.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

class JogsViewModel {
    private let authorizationClient = NetworkClientsFactory.shared.authorizationClient
    private let jogsClient = NetworkClientsFactory.shared.jogsClient
    //private let userUuid = UUID().uuidString
    private let mockedUserUuid = "hello"
    let accessToken = UserAccountManager.accessToken
    
    func authorizeUser(success: @escaping() -> Void, failure: @escaping(String) -> Void) {
        authorizationClient.authorize(uuid: mockedUserUuid).onSuccess { response in
            UserAccountManager.accessToken = response.accessToken
            success()
        }.onFailure { error in
            switch error {
            case .networkRequestFailed:
                failure("An error occurred in the application. Try again.")
            case .tokenExpired:
                failure("Login failed. Please log in again.")
            }
        }
    }
    
    func addNewJog(_ jog: Jog, success: @escaping() -> Void, failure: @escaping(String) -> Void) {
        jogsClient.addNewJog(jog: jog).onSuccess { _ in
            success()
        }.onFailure { error in
            switch error {
            case .networkRequestFailed:
                failure("An error occurred in the application. Try again.")
            case .tokenExpired:
                failure("Login failed. Please log in again.")
            }
        }
    }
    
    func getExistingJogs(success: @escaping(JogsList?) -> Void, failure: @escaping(String) -> Void) {
        DataManager.shared.getExistingJogs(success: { jogs in
            success(jogs)
        }, failure: { error in
            failure(error)
        })
    }
    
}
