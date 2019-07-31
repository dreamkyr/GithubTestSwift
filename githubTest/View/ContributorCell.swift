//
//  ContributorCell.swift
//  githubTest
//
//  Created by dreams on 7/31/19.
//  Copyright © 2019 Dreams. All rights reserved.
//

import UIKit

class ContributorCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelContribution: UILabel!
    @IBOutlet weak var btnMap: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
