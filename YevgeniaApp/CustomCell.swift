//
//  CustomCell.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 17.04.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var label_Place: UILabel!
    @IBOutlet var label_time: UILabel!
    @IBOutlet var label_Name: UILabel!
    @IBOutlet var label_WorkshopName: UILabel!
    @IBOutlet var imageViewPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
