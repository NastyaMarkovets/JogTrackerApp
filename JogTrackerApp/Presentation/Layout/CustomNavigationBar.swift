//
//  CustomNavigationBar.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/16/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol RightButtonActionProtocol: class {
    func clickRightButton()
}

class CustomNavigationBar: UIView {
    
    private enum Dimensions {
        static let navigationBarHeight: CGFloat = 77
        static let contentSpacing: CGFloat = 20
        static let sideInset: CGFloat = 25
        static let filterWidth: CGFloat = 39
    }
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(didTapedRightButton), for: .touchUpInside)
        return button
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(didTapedFilterButton), for: .touchUpInside)
        return button
    }()
    
    private var filterIsNeeded = false {
        didSet {
            filterButton.isHidden = !filterIsNeeded
        }
    }
    
    private var filterIsActive = false {
        didSet {
            filterIsActive ? filterButton.setImage(UIImage(named: "filter-active"), for: .normal)
                : filterButton.setImage(UIImage(named: "filter"), for: .normal)
        }
    }
    
    weak var rightButtonDelegate: RightButtonActionProtocol?

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        backgroundColor = UIColor.Base.appleGreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(logoImageView)
        addSubview(rightButton)
        addSubview(filterButton)
    }
    
    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Dimensions.navigationBarHeight + UIApplication.shared.statusBarFrame.height)
        }
        
        logoImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Dimensions.contentSpacing)
            $0.leading.equalToSuperview().inset(Dimensions.sideInset)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Dimensions.sideInset)
            $0.centerY.equalTo(logoImageView)
        }
        
        filterButton.snp.makeConstraints {
            $0.trailing.equalTo(rightButton.snp.leading).offset(-Dimensions.filterWidth)
            $0.centerY.equalTo(logoImageView)
            $0.width.equalTo(Dimensions.filterWidth)
        }
    }
    
    @objc private func didTapedRightButton() {
        rightButtonDelegate?.clickRightButton()
    }
    
    @objc private func didTapedFilterButton() {
        filterIsActive = !filterIsActive
    }
    
    func setupMenuNavigationBar() {
        backgroundColor = .white
        rightButton.setImage(UIImage(named: "cancel"), for: .normal)
        rightButton.tintColor = UIColor.Base.greyish
        logoImageView.tintColor = UIColor.Base.appleGreen
    }
    
    func addFilter() {
        filterIsNeeded = true
        filterIsActive = false
    }

}
