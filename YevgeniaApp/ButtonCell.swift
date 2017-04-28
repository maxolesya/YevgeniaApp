//
//  ButtonCell.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 22.04.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet var labelQuestion: UILabel!

    
    @IBAction func button_Answer_Click(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //button_ChosenAnswer.clipsToBounds = true;
       // button_ChosenAnswer.layer.cornerRadius = 5;

        // Configure the view for the selected state
    }
    
   

}
