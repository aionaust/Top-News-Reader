//
//  CountryNameTableCell.swift
//  Parsing Test
//
//  Created by Saif Aion on 5/8/17.
//  Copyright © 2017 Saif Aion. All rights reserved.
//

import UIKit

class CountryNameTableCell: UITableViewCell {
    
    

    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var authorLabel: UILabel!

    @IBOutlet var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
