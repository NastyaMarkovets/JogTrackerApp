//
//  Jog.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

struct Jog: Codable {
    let id: Int?
    let userId: Int?
    let distance: Float
    let time: Int
    let date: String
    
    init(id: Int? = nil, userId: Int? = nil, distance: Float, time: Int, date: String) {
        self.id = id
        self.userId = userId
        self.distance = distance
        self.time = time
        self.date = date
    }
    
    private enum CodingKeys : String, CodingKey {
        case response
        case id, userId = "user_id", distance, time, date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        id = try response.decode(Int.self, forKey: .id)
        userId = try response.decode(Int.self, forKey: .userId)
        distance = try response.decode(Float.self, forKey: .distance)
        time = try response.decode(Int.self, forKey: .time)
        date = try response.decode(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        try response.encode(id, forKey: .id)
        try response.encode(userId, forKey: .userId)
        try response.encode(distance, forKey: .distance)
        try response.encode(time, forKey: .time)
        try response.encode(date, forKey: .date)
    }
}
