//
//  CustomButton.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/16/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    private enum Dimensions {
        static let buttonHeight: CGFloat = 60
        static let borderWidth: CGFloat = 3
    }
        
    init(title: String) {
        super.init(frame: .zero)
            
        setTitle(title, for: .normal)
        prepareButton()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareButton() {
        titleLabel?.font = UIFont.Base.buttonFont
        setTitleColor(UIColor.Base.babyPurple, for: .normal)
        layer.borderWidth = Dimensions.borderWidth
        layer.borderColor = UIColor.Base.babyPurple.cgColor
        layer.cornerRadius = Dimensions.buttonHeight / 2
        
        snp.makeConstraints {
            $0.height.equalTo(Dimensions.buttonHeight)
        }
    }

}
