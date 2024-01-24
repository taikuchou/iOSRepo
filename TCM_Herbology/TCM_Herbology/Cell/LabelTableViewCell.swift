//
//  LabelTableViewCell.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/24.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
