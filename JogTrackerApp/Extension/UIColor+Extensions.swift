//
//  UIColor+Extensions.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct Base {
        static let backgroundColor = UIColor.white
        static let textColor = UIColor(70, 67, 71)
        static let warmGrey = UIColor(151, 151, 151)
        static let appleGreen = UIColor(126, 211, 33)
        static let greyish = UIColor(176, 171, 171)
        static let babyPurple = UIColor(233, 144, 249)
    }

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double? = 1.0) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
