//
//  UITableViewCell+Extension.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let customNavigationBar = CustomNavigationBar()
    private let contentView = UIView()
    private let menuViewController = MenuViewController()
    var rootViewController: UIViewController = JogsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.backgroundColor
        self.navigationController?.isNavigationBarHidden = true
        addSubviews()
        setupConstraints()
        customNavigationBar.rightButtonDelegate = self
        addRootViewController()
    }
    
    private func addRootViewController() {
        add(rootViewController, contentView: contentView)
    }
    
    private func addSubviews() {
        view.addSubview(customNavigationBar)
        view.addSubview(contentView)
    }
    
    private func setupConstraints() {
        customNavigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: MenuItemsSelectionProtocol {
    func didSelectMenu(item: UIViewController) {
        rootViewController.remove()
        rootViewController = item
        add(item, contentView: contentView)
    }
}

extension MainViewController: RightButtonActionProtocol {
    func clickRightButton() {
        menuViewController.menuItemsSelectionDelegate = self
        navigationController?.pushViewController(menuViewController, animated: true)
    }
}
