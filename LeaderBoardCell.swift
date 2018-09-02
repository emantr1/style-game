//
//  LeaderBoardCell.swift
// Fd
//
//  Created by Eman I on 1/8/16.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

class LeaderBoardCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userScore: UILabel!
    @IBOutlet var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.layer.borderColor = UIColor.blackColor().CGColor
        userImage.layer.borderWidth =  1
        // Configure the view for the selected state
    }

}
