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
        static let accentColor = UIColor.lightGray
        static let textColor = UIColor.black
        static let subtextColor = UIColor.darkGray
        static let selectionColor = accentColor.withAlphaComponent(0.2)
        static let errorColor = UIColor.red
    }

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double? = 1.0) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
