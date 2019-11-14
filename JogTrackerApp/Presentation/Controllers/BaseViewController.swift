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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.backgroundColor
        addLogo()
        setupBaseNavigationBar()
    }
    
    func setupBaseNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.Base.appleGreen
        navigationController?.navigationBar.tintColor = .white
        let menuIcon = UIImage(named: "menu")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: menuIcon, style: .plain, target: self, action: #selector(didTapedMenu))
    }
    
    @objc private func didTapedMenu() {
        let menuViewController = MenuViewController()
        navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    func addLogo() {
        let logoIcon = UIImage(named: "logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoIcon, style: .plain, target: nil, action: nil)
    }
    
    func whiteNavigationBarSetup() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        navigationController?.navigationBar.tintColor = UIColor.Base.appleGreen
    }
    
}
