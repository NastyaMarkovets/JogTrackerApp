//
//  UIViewController+Extensions.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController, contentView: UIView? = nil) {
        let aView = contentView != nil ? contentView : self.view
        guard let view = aView else {
            return
        }
        addChild(child)
        view.addSubview(child.view)
        constraintViewEqual(holderView: view, view: child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func constraintViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: holderView.bottomAnchor).isActive = true
    }
    
}
