///Users/olesa/Documents/Olesya/HSE/HSEProject/YevgeniaApp/YevgeniaApp/ButtonCell.swift
//  VotingController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 19.04.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation
import UIKit
class VotingController : UIViewController {
    var list:[Human] = [Human(name:"Николай")]
    var listTeaachers:[Human] = [Human(name:"Анастасия Владимировна")]
    
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var label_Workshop: UILabel!
}
