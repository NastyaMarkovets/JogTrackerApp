//
//  UserStatusManager.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation
import KeychainSwift

class UserAccountManager {
    static private let keychain = KeychainSwift()
    static let accessTokenKey = "access_token"
 
    static func getAccountToken() -> String? {
        return keychain.get(accessTokenKey)
    }
    
    static func setAccountToken(_ token: String) {
        keychain.set(token, forKey: accessTokenKey)
    }
    
    static func deleteAccountToken() {
        keychain.delete(accessTokenKey)
    }
}
