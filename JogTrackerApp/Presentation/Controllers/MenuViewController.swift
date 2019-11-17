//
//  MenuViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol MenuItemsSelectionProtocol: class {
    func didSelectMenu(item: UIViewController)
}

class MenuViewController: UIViewController {
    
    private enum Dimensions {
        static let cellHeight: CGFloat = 71
        static let tableViewMultiplier: CGFloat = 0.8
    }
    
    private enum MenuItem: String, CaseIterable {
        case jogs = "Jogs"
        case info = "Info"
        case contactUs = "Contact Us"
        
        func getIndex() -> Int? {
            return MenuItem.allCases.firstIndex { self == $0 }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let customNavigationBar = CustomNavigationBar()
    private let menuItems = MenuItem.allCases
    private var selectedMenuItem: MenuItem = .jogs
    weak var menuItemsSelectionDelegate: MenuItemsSelectionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Base.backgroundColor
        customNavigationBar.setupMenuNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        customNavigationBar.rightButtonDelegate = self
        registerNib()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let index = selectedMenuItem.getIndex() else { return }
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
    }
    
    private func addSubviews() {
        view.addSubview(customNavigationBar)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        customNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(Dimensions.tableViewMultiplier)
            $0.height.equalTo(Dimensions.cellHeight * CGFloat(menuItems.count))
            $0.top.greaterThanOrEqualTo(customNavigationBar.snp.bottom)
        }
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: MenuTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MenuTableViewCell.identifier())
    }
}

extension MenuViewController: RightButtonActionProtocol {
    func clickRightButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier(), for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        cell.menuItemTitle = menuItems[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimensions.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard selectedMenuItem != menuItems[indexPath.row] else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        selectedMenuItem = menuItems[indexPath.row]
        var presentingController: UIViewController?
        switch selectedMenuItem {
        case .jogs:
            presentingController = JogsViewController()
        case .info:
            presentingController = InfoViewController()
        case .contactUs:
            presentingController = UIViewController()
        }
        if let presentingController = presentingController {
            menuItemsSelectionDelegate?.didSelectMenu(item: presentingController)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
