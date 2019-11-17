//
//  AuthorizationViewModel.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

class AuthorizationViewModel {
    
    private let authorizationClient = NetworkClientsFactory.shared.authorizationClient
    //private let userUuid = UUID().uuidString
    private let mockedUserUuid = "hello"
    let accessToken = UserAccountManager.accessToken
    
    func authorizeUser(success: @escaping() -> Void, failure: @escaping(String) -> Void) {
        authorizationClient.authorize(uuid: mockedUserUuid).onSuccess { response in
            UserAccountManager.accessToken = response.response.accessToken
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
}
