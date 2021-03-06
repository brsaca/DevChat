//
//  UserCell.swift
//  DevChat
//
//  Created by brenda saavedra on 20/09/16.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(user:User){
        firstNameLbl.text = user.firstName
    }

    func setCheckmark(selected:Bool){
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }
}
