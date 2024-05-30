//
//  TrainingCell.swift
//  TrainsProject
//
//  Created by user262074 on 5/29/24.
//

import UIKit

class TrainingCell: UITableViewCell {

    @IBOutlet weak var trainNameLable: UILabel!
    
    @IBOutlet weak var caloriesLable: UILabel!
    @IBOutlet weak var trainDurationTimeLabe: UILabel!
    @IBOutlet weak var trainDateLabe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
