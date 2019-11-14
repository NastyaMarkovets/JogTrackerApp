//
//  UIFont+Extensions.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum Monserrat: String {
        
        case light = "HelveticaNeue-Light"
        case regular = "HelveticaNeue-Regular"
        case bold = "HelveticaNeue-Bold"
        case medium = "HelveticaNeue-Medium"
        
        func of(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        }

    }

    struct Base {
        static let titleFont = UIFont.Monserrat.medium.of(size: 18)
        static let descriptionFont = UIFont.Monserrat.medium.of(size: 14)
        static let headerFont = UIFont.Monserrat.medium.of(size: 22)
    }
    
}
