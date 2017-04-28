//
//  TemplateCell.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 15.02.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import UIKit

class TemplateCell: UITableViewCell {

   
    @IBOutlet var labelPlace: UILabel!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelType: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
