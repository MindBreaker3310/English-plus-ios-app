//
//  VocabularyCell.swift
//  EnglishPlus
//
//  Created by Max on 2019/6/7.
//  Copyright © 2019 MAX. All rights reserved.
//

import UIKit

class VocabularyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
