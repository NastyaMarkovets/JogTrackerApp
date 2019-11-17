//
//  JogsViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class JogsViewController: UIViewController {
    
    private let authorizationView = AuthorizationView()
    private let authorizationViewModel = AuthorizationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        authorizationView.authorizationButtonDelegate = self
        checkUserIsAuthorized()
    }
    
    private func addSubviews() {
        view.addSubview(authorizationView)
    }
    
    private func setupConstraints() {
        authorizationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func checkUserIsAuthorized() {
        let isAuthorized = authorizationViewModel.accessToken != nil
        authorizationView.isHidden = isAuthorized
    }
}

extension JogsViewController: AuthorizathionButtonProtocol {
    func clickAuthorization() {
        authorizationViewModel.authorizeUser(success: { [weak self] in
            guard let self = self else { return }
            self.authorizationView.isHidden = true
        }, failure: { error in
            print(error)
        })
    }
}
