//
//  DataManager.swift
//  JogTrackerApp
//
//  Created by iMac on 18/11/2019.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

class DataManager {

    static let shared = DataManager()
    private let jogsClient = NetworkClientsFactory.shared.jogsClient

    private init() {}

    private var existingJogs: JogsList?
    
    func getExistingJogs(success: @escaping(JogsList?) -> Void, failure: @escaping(String) -> Void) {
        guard existingJogs == nil else { return success(existingJogs) }
        jogsClient.getExistingJogs().onSuccess { [weak self] jogs in
            self?.existingJogs = jogs
            success(self?.existingJogs)
        }.onFailure { error in
            switch error {
            case .networkRequestFailed:
                failure("An error occurred in the application. Try again.")
            case .tokenExpired:
                failure("Login failed. Please log in again.")
            }
        }
    }
    
    func clearExistingJogs() {
        existingJogs = nil
    }
    
}
