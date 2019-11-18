//
//  JogsViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol NewControllerProtocol: class {
    func addNew(controller: UIViewController)
}

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
        button.addTarget(self, action: #selector(addNewJog), for: .touchUpInside)
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
      let indicator = UIActivityIndicatorView()
      indicator.backgroundColor = .white
      indicator.hidesWhenStopped = true
      indicator.style = .gray
      return indicator
    }()
    
    private let tableView = UITableView()
    private let authorizationView = AuthorizationView()
    private let emptyJogsListView = EmptyJogsListView()
    weak var newControllerDelegate: NewControllerProtocol?
    private let jogsViewModel = JogsViewModel()
    var existingJogs: JogsList? {
        didSet {
            tableView.reloadData()
            checkExistingJogs()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        activityIndicator.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        authorizationView.authorizationButtonDelegate = self
        emptyJogsListView.firstJogCreatingDelegate = self
        checkUserIsAuthorized()
        registerNib()        
        getExistingJogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(addJogButton)
        view.addSubview(emptyJogsListView)
        view.addSubview(authorizationView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        authorizationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        emptyJogsListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addJogButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(Dimensions.contentInset)
            $0.height.width.equalTo(Dimensions.addButtonSize)
        }
    }
    
    private func getExistingJogs() {
        jogsViewModel.getExistingJogs(success: { [weak self] jogs in
            guard let self = self else { return }
            self.existingJogs = jogs
            self.activityIndicator.stopAnimating()
        }, failure: { error in
            self.activityIndicator.stopAnimating()
            print(error)
        })
    }
    
    private func checkUserIsAuthorized() {
        let isAuthorized = jogsViewModel.accessToken != nil
        authorizationView.isHidden = isAuthorized
    }
    
    private func checkExistingJogs() {
        let isEmptyJogsList = existingJogs == nil
        emptyJogsListView.isHidden = !isEmptyJogsList
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: JogTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: JogTableViewCell.identifier())
    }
    
    @objc private func addNewJog() {
        let newJogViewController = NewJogViewController()
        newJogViewController.newJogDelegate = self
        newControllerDelegate?.addNew(controller: newJogViewController)
    }
}

extension JogsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existingJogs?.jogs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JogTableViewCell.identifier(), for: indexPath) as? JogTableViewCell else {
            return UITableViewCell()
        }
        cell.jogInfo = existingJogs?.jogs[indexPath.row]
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
        addNewJog()
    }
}

extension JogsViewController: NewJogProtocol {
    func updateExistingJogs() {
        existingJogs = nil
        DataManager.shared.clearExistingJogs()
        activityIndicator.startAnimating()
        getExistingJogs()
    }
}
