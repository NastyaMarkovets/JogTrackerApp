//
//  User.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 13/11/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct User: Codable {
    let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    private enum CodingKeys : String, CodingKey {
        case response
        case accessToken = "access_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        accessToken = try response.decode(String.self, forKey: .accessToken)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        try response.encode(accessToken, forKey: .accessToken)
    }
}
