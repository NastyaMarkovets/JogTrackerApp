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
        button.addTarget(self, action: #selector(didTapedMenu), for: .touchUpInside)
        return button
    }()
    
    enum RightButtonType {
        case menu
        case cancel
    }
    var rightButtonType: RightButtonType = .menu
    
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
            $0.bottom.equalToSuperview().inset(Dimensions.sideInset)
        }
    }
    
    func setupMenuNavigationBar() {
        baseNavigationBarView.backgroundColor = .white
        rightButton.setImage(UIImage(named: "cancel"), for: .normal)
        rightButton.tintColor = UIColor.Base.greyish
        logoImageView.tintColor = UIColor.Base.appleGreen
        rightButtonType = .cancel
    }
    
    @objc private func didTapedMenu() {
        switch rightButtonType {
        case .menu:
            let menuViewController = MenuViewController()
            navigationController?.pushViewController(menuViewController, animated: true)
        case .cancel:
            navigationController?.popViewController(animated: true)
        }
    }

}
