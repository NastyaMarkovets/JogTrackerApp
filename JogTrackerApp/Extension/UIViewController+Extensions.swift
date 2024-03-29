//
//  UIViewController+Extensions.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func add(_ child: UIViewController, contentView: UIView? = nil) {
        let contentView = contentView != nil ? contentView : self.view
        guard let view = contentView else {
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
        view.snp.makeConstraints {
            $0.edges.equalTo(holderView)
        }
    }
    
}
