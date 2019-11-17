//
//  Response.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct Response: Codable {
    let response: UserResponse
    
    init(response: UserResponse) {
        self.response = response
    }
    
    private enum CodingKeys : String, CodingKey {
        case response = "response"
    }
}
