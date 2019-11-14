//
//  MenuViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.backgroundColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        whiteNavigationBarSetup()
        let cancelIcon = UIImage(named: "cancel")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cancelIcon, style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.Base.greyish
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupBaseNavigationBar()
    }
    
    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }

}
