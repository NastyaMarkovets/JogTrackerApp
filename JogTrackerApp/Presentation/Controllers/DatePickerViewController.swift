//
//  DatePickerViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

protocol DateSelectionProtocol: class {
    func didSelect(date: String)
}

class DatePickerViewController: UIViewController {
    
    private enum Dimensions {
        static let buttonHeight: CGFloat = 42
        static let buttonInset: CGFloat = 20
    }
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        return datePicker
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.Base.appleGreen, for: .normal)
        return button
    }()
    
    private let containerButtonsView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    weak var dateSelectionDelegate: DateSelectionProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.isOpaque = false
        view.backgroundColor = .clear
        addSubviews()
        setupConstraints()
        doneButton.addTarget(self, action: #selector(didTappedDone), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.2) {
                self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != datePicker {
            dismissPickerView()
        }
    }
    
    private func dismissPickerView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func addSubviews() {
        view.addSubview(containerButtonsView)
        containerButtonsView.addSubview(doneButton)
        view.addSubview(datePicker)
    }
    
    private func setupConstraints() {
        doneButton.snp.makeConstraints {
            $0.height.equalTo(Dimensions.buttonHeight)
            $0.trailing.equalToSuperview().inset(Dimensions.buttonInset)
            $0.top.bottom.equalToSuperview()
        }
        containerButtonsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(datePicker.snp.top)
        }
        datePicker.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(view.frame.height / 3)
        }
    }
    
    @objc private func didTappedDone() {
        dateSelectionDelegate?.didSelect(date: datePicker.date.getStringFromDate())
        dismissPickerView()
    }

}
