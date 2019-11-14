//
//  User.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 13/11/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct User: Codable {
    let accessToken: String?
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    private enum CodingKeys : String, CodingKey {
        case accessToken = "access_token"
    }
}
