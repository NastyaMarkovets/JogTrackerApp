//
//  AuthorizationViewModel.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    private let authorizationClient = NetworkClientsFactory.shared.authorizationClient
    let userUuid = "hello" //UUID().uuidString
    
    func loginUser(success: @escaping(User) -> Void, failure: @escaping(String) -> Void) {
        authorizationClient.login(uuid: userUuid).onSuccess { user in
            success(user)
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
