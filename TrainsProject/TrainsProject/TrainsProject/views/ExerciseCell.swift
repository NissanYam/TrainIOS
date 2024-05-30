//
//  ExerciseCell.swift
//  TrainsProject
//
//  Created by user262074 on 5/29/24.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var exerciseWeightLable: UILabel!
    @IBOutlet weak var ExercsieReipitsLable: UILabel!
    @IBOutlet weak var exerciseSetsLable: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
