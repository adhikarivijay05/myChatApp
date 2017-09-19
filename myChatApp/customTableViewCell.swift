//
//  customTableViewCell.swift
//  myChatApp
//
//  Created by Vijay Adhikari on 14/09/2017.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
