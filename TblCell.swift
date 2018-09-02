//
//  TblCell.swift
// Fd
//
//  Created by Eman I on 1/4/16.
//  Copyright © 2016 Eman. All rights reserved.
//

import UIKit

class TblCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var userImage1: UIImageView!
    @IBOutlet var gameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       /* userImage1.layer.cornerRadius = userImage1.frame.size.width / 2
        userImage1.clipsToBounds = true
        userImage1.layer.borderColor = UIColor.blackColor().CGColor
        userImage1.layer.borderWidth =  2*/
        
       
        // Configure the view for the selected state
    }

}
