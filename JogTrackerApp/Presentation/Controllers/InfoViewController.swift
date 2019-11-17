//
//  InfoViewController.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private enum Dimensions {
        static let textViewContentInset: CGFloat = 5
        static let contentInset: CGFloat = 25
        static let contentSpacing: CGFloat = 6
        static let descriptionLineHeight: CGFloat = 24
        static let descriptionFontSize: CGFloat = 12
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Base.titleFont
        label.textColor = UIColor.Base.appleGreen
        label.text = "Info".uppercased()
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.Base.descriptionFont
        textView.textColor = UIColor.Base.textColor
        textView.isSelectable = false
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -Dimensions.textViewContentInset, bottom: 0, right: 0)
        textView.showsVerticalScrollIndicator = false
        let descriptionText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        let attributedString = NSMutableAttributedString(string: descriptionText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Dimensions.descriptionLineHeight - Dimensions.descriptionFontSize
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        textView.attributedText = attributedString
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Dimensions.contentInset)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.contentSpacing)
            $0.leading.trailing.bottom.equalToSuperview().inset(Dimensions.contentInset)
        }
    }

}
