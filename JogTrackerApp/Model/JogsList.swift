//
//  JogsList.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/18/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct JogsList: Codable {
    var jogs: [ExistingJog]
    
    init(jogs: [ExistingJog]) {
        self.jogs = jogs
    }
    
    private enum CodingKeys: String, CodingKey {
        case response
        case jogs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        jogs = try response.decode([ExistingJog].self, forKey: .jogs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        try response.encode(jogs, forKey: .jogs)
    }
}
