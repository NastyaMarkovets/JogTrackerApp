//
//  Date+extensions.swift
//  JogTrackerApp
//
//  Created by iMac on 18/11/2019.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import Foundation

extension Date {

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func getStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
