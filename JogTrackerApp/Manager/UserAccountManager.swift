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
    static var accessToken: String? {
        get {
            return keychain.get(accessTokenKey)
        }
        set {
            guard let accessToken = newValue else { return }
            keychain.set(accessToken, forKey: accessTokenKey)
        }
    }
    
    static func deleteAccountToken() {
        keychain.delete(accessTokenKey)
    }
}
