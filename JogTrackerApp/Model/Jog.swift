//
//  Jog.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct Jog: Codable {
    let id: Int
    let userId: String
    let distance: Float
    let time: Int
    let date: String
    
    init(id: Int, userId: String, distance: Float, time: Int, date: String) {
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
