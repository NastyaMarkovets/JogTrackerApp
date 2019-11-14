//
//  KeyboardListener.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/14/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class KeyboardListener {
    
    private let listener: Listener
    private let view: UIView
    
    typealias Listener = (CGFloat) -> Void
    
    init(view: UIView, listener: @escaping Listener) {
        self.view = view
        self.listener = listener
    }
    
    deinit {
        stop()
    }
    
    @objc private func onKeyboardWillShow(notification: NSNotification) {
        guard let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: duration) { [weak self] in
            let keyboardHeight = targetFrame.size.height - (self?.view.safeAreaInsets.bottom ?? 0)
            self?.listener(keyboardHeight)
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc private func onKeyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: duration) { [weak self] in
            let keyboardHeight: CGFloat = 0.0
            self?.listener(keyboardHeight)
            self?.view.layoutIfNeeded()
        }
    }
    
    func start() {
        stop()
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stop() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
