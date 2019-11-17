//
//  JogsViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class JogsViewController: UIViewController {
    
    private enum Dimensions {
        static let cellHeight: CGFloat = 188
        static let contentInset: CGFloat = 30
        static let addButtonSize: CGFloat = 47
    }
    
    private let addJogButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = Dimensions.addButtonSize / 2
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(didTapedAddButton), for: .touchUpInside)
        return button
    }()
    
    private let tableView = UITableView()
    private let authorizationView = AuthorizationView()
    private let emptyJogsListView = EmptyJogsListView()
    private let jogsViewModel = JogsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        authorizationView.authorizationButtonDelegate = self
        emptyJogsListView.firstJogCreatingDelegate = self
        checkUserIsAuthorized()
        checkExistingJogs()
        registerNib()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(addJogButton)
        view.addSubview(emptyJogsListView)
        view.addSubview(authorizationView)
    }
    
    private func setupConstraints() {
        authorizationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        emptyJogsListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addJogButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(Dimensions.contentInset)
            $0.height.width.equalTo(Dimensions.addButtonSize)
        }
    }
    
    private func checkUserIsAuthorized() {
        let isAuthorized = jogsViewModel.accessToken != nil
        authorizationView.isHidden = isAuthorized
    }
    
    private func checkExistingJogs() {
        let isEmptyJogsList = jogsViewModel.existingJogs == nil
        emptyJogsListView.isHidden = !isEmptyJogsList
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: JogTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: JogTableViewCell.identifier())
    }
    
    @objc private func didTapedAddButton() {
        
    }
}

extension JogsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jogsViewModel.existingJogs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JogTableViewCell.identifier(), for: indexPath) as? JogTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimensions.cellHeight
    }
}

extension JogsViewController: AuthorizathionButtonProtocol {
    func clickAuthorization() {
        jogsViewModel.authorizeUser(success: { [weak self] in
            guard let self = self else { return }
            self.authorizationView.isHidden = true
        }, failure: { error in
            print(error)
        })
    }
}

extension JogsViewController: FirstJogCreatingProtocol {
    func createJogFirst() {
        didTapedAddButton()
    }
}
