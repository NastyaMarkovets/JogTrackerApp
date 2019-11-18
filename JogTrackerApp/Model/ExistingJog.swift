//
//  ExistingJog.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/18/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct ExistingJog: Codable {
    let id: Int?
    let userId: String?
    let distance: Float
    let time: Int
    let date: Int
    
    init(id: Int, userId: String, distance: Float, time: Int, date: Int) {
        self.id = id
        self.userId = userId
        self.distance = distance
        self.time = time
        self.date = date
    }
    
    private enum CodingKeys : String, CodingKey {
        case id, userId = "user_id", distance, time, date
    }
}
