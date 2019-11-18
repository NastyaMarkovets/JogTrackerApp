//
//  AuthorizationView.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/16/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol AuthorizathionButtonProtocol: class {
    func clickAuthorization()
}

class AuthorizationView: UIView {
    
    private enum Dimensions {
        static let buttonHeight: CGFloat = 60
        static let borderWidth: CGFloat = 3
        static let sideInset: CGFloat = 110
        static let spacing: CGFloat = 103
        static let bottomInset: CGFloat = 136
        static let iconWidth: CGFloat = 160
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bear-face")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let contentView = UIView()
    private let letMeInButton = CustomButton(title: "Let me in")
    weak var authorizationButtonDelegate: AuthorizathionButtonProtocol?
    
    init() {
        super.init(frame: .zero)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(letMeInButton)
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
        }
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(Dimensions.iconWidth)
            $0.centerX.equalToSuperview()
        }
        letMeInButton.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(Dimensions.spacing)
            $0.leading.trailing.equalTo(iconImageView)
            $0.bottom.equalToSuperview()
        }
        
        letMeInButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
    }
    
    @objc private func authorize() {
        authorizationButtonDelegate?.clickAuthorization()
    }

}
