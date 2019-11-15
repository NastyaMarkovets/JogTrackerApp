//
//  UITableViewCell+Extension.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    private enum Dimensions {
        static let navigationBarHeight: CGFloat = 77
        static let contentSpacing: CGFloat = 20
        static let sideInset: CGFloat = 25
        static let filterWidth: CGFloat = 39
    }
    
    private let baseNavigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Base.appleGreen
        return view
    }()
    
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
    
    private enum RightButtonType {
        case menu
        case cancel
    }
    private var rightButtonType: RightButtonType = .menu
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.backgroundColor
        self.navigationController?.isNavigationBarHidden = true
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(baseNavigationBarView)
        baseNavigationBarView.addSubview(logoImageView)
        baseNavigationBarView.addSubview(rightButton)
        baseNavigationBarView.addSubview(filterButton)
    }
    
    private func setupConstraints() {
        baseNavigationBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
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
        switch rightButtonType {
        case .menu:
            let menuViewController = MenuViewController()
            navigationController?.pushViewController(menuViewController, animated: true)
        case .cancel:
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapedFilterButton() {
        filterIsActive = !filterIsActive
    }
    
    func setupMenuNavigationBar() {
        baseNavigationBarView.backgroundColor = .white
        rightButton.setImage(UIImage(named: "cancel"), for: .normal)
        rightButton.tintColor = UIColor.Base.greyish
        logoImageView.tintColor = UIColor.Base.appleGreen
        rightButtonType = .cancel
    }
    
    func addFilter() {
        filterIsNeeded = true
        filterIsActive = false
    }

}
