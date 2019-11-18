//
//  MenuTableViewCell.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/15/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemLabel: UILabel!
    
    var menuItemTitle: String? {
        didSet {
            guard let title = menuItemTitle else { return }
            menuItemLabel.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        menuItemLabel.textColor = selected ? UIColor.Base.appleGreen : UIColor.Base.textColor
    }
    
}
