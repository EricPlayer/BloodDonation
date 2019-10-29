//
//  ResultTVCell.swift
//  Rafd
//
//  Created by eric on 3/20/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit

class ResultTVCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var bloodLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
