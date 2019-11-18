//
//  NewJogPopUpView.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class NewJogViewController: UIViewController {
    private enum Dimensions {
        static let buttonHeight: CGFloat = 42
        static let textFieldHeight: CGFloat = 31
        static let borderWidth: CGFloat = 2
        static let contentInset: CGFloat = 35
        static let contentSpacing: CGFloat = 20
        static let labelBottomOffset: CGFloat = 6
        static let buttonOffset: CGFloat = 41
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Base.appleGreen
        view.isHidden = true
        view.layer.cornerRadius = 29
        return view
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.tintColor = .white
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Dimensions.buttonHeight / 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = Dimensions.borderWidth
        button.addTarget(self, action: #selector(saveNewJog), for: .touchUpInside)
        return button
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Base.popUpLabelFont
        label.textColor = UIColor.Base.textColor
        label.text = "Distance"
        return label
    }()
    
    private let distanceTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.Base.popUpLabelFont
        textField.textColor = UIColor.Base.textColor
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Base.popUpLabelFont
        label.textColor = UIColor.Base.textColor
        label.text = "Time"
        return label
    }()
    
    private let timeTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.Base.popUpLabelFont
        textField.textColor = UIColor.Base.textColor
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Base.popUpLabelFont
        label.textColor = UIColor.Base.textColor
        label.text = "Date"
        return label
    }()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.Base.popUpLabelFont
        textField.textColor = UIColor.Base.textColor
        textField.borderStyle = .roundedRect
        textField.isSelected = false
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let jogsViewModel = JogsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        tapsSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(with: contentView, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.contentView.isHidden = false
        })
    }
    
    private func tapsSetup() {
        let tapAround = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapAround.cancelsTouchesInView = false
        view.addGestureRecognizer(tapAround)
        
        let tapDateTextField = UITapGestureRecognizer(target: self, action: #selector(showDataPicker))
        dateTextField.addGestureRecognizer(tapDateTextField)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
        contentView.addSubview(cancelButton)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(distanceTextField)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeTextField)
        contentView.addSubview(dateLabel)
        contentView.addSubview(dateTextField)
        contentView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
            $0.centerY.equalToSuperview()
        }
        cancelButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Dimensions.contentSpacing)
        }
        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(Dimensions.contentSpacing)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
        }
        distanceTextField.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.bottom).offset(Dimensions.labelBottomOffset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
            $0.height.equalTo(Dimensions.textFieldHeight)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(distanceTextField.snp.bottom).offset(Dimensions.contentSpacing)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
        }
        timeTextField.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(Dimensions.labelBottomOffset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
            $0.height.equalTo(Dimensions.textFieldHeight)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(timeTextField.snp.bottom).offset(Dimensions.contentSpacing)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
        }
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(Dimensions.labelBottomOffset)
            $0.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
            $0.height.equalTo(Dimensions.textFieldHeight)
        }
        saveButton.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(Dimensions.buttonOffset)
            $0.height.equalTo(Dimensions.buttonHeight)
            $0.leading.trailing.bottom.equalToSuperview().inset(Dimensions.contentInset)
        }
    }
    
    @objc private func saveNewJog() {
        guard let distanceText = distanceTextField.text,
            let timeText = timeTextField.text,
            let date = dateTextField.text,
            let distance = Float(distanceText),
            let time = Int(timeText), !date.isEmpty else { return }
        
        let newJog = Jog(distance: distance, time: time, date: date)
        jogsViewModel.addNewJog(newJog, success: { [weak self] in
            self?.remove()
        }, failure: { error in
            print(error)
        })
    }
    
    @objc private func showDataPicker() {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.modalPresentationStyle = .overCurrentContext
        datePickerViewController.dateSelectionDelegate = self
        present(datePickerViewController, animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        remove()
    }
}

extension NewJogViewController: DateSelectionProtocol {
    func didSelect(date: String) {
        dateTextField.text = date
    }
}
