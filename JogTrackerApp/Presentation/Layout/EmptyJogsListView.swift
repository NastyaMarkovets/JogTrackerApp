//
//  EmptyJogsListView.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol FirstJogCreatingProtocol: class {
    func createJogFirst()
}

class EmptyJogsListView: UIView {

    private enum Dimensions {
        static let iconWidth: CGFloat = 86
        static let buttonInset: CGFloat = 62
        static let bottomInset: CGFloat = 71
        static let contentSpacing: CGFloat = 30
        static let iconSpacing: CGFloat = 145
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sad-emotion")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nothingIsThereLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Base.subTitleFont
        label.textColor = UIColor.Base.greyish
        label.textAlignment = .center
        label.text = "Nothing is there"
        return label
    }()
    
    private let createJogButton = CustomButton(title: "Create your jog first")
    weak var firstJogCreatingDelegate: FirstJogCreatingProtocol?
    
    init() {
        super.init(frame: .zero)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        backgroundColor = .white
        
        addSubview(iconImageView)
        addSubview(nothingIsThereLabel)
        addSubview(createJogButton)
        
        iconImageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview()
            $0.width.equalTo(Dimensions.iconWidth)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nothingIsThereLabel.snp.top).offset(-Dimensions.contentSpacing)
        }
        nothingIsThereLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentSpacing)
            $0.bottom.equalTo(createJogButton.snp.top).offset(-Dimensions.iconSpacing)
        }
        createJogButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Dimensions.buttonInset)
            $0.bottom.equalToSuperview().inset(Dimensions.bottomInset)
        }
        
        createJogButton.addTarget(self, action: #selector(createNewJog), for: .touchUpInside)
    }
    
    @objc private func createNewJog() {
        firstJogCreatingDelegate?.createJogFirst()
    }

}
