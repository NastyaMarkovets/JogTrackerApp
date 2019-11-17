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
    var existingJogs: JogsList?
    
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
        jogsClient.addNewJog(jog: jog).onSuccess { [weak self] jog in
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
    
    func getExistingJogs() {
        guard existingJogs == nil else { return }
        jogsClient.getExistingJogs().onSuccess { [weak self] jogs in
            self?.existingJogs = jogs
        }.onFailure { error in
            switch error {
            case .networkRequestFailed:
                print("An error occurred in the application. Try again.")
            case .tokenExpired:
                print("Login failed. Please log in again.")
            }
        }
    }
    
}
