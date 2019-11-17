//
//  JogTableViewCell.swift
//  JogTrackerApp
//
//  Created by Anastasia Markovets on 11/17/19.
//  Copyright © 2019 Lonely Tree Std. All rights reserved.
//

import UIKit

class JogTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var jogInfo: Jog? {
        didSet {
            guard let jog = jogInfo else { return }
            dateLabel.text = jog.date
            speedLabel.text = "\(jog.distance / Float(jog.time))"
            distanceLabel.text = "\(jog.distance) km"
            timeLabel.text = "\(jog.time) min"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
