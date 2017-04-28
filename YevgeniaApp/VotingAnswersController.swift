//
//  VotingAnswersController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 22.04.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation
import UIKit
class VotingAnswersController : UIViewController,UITableViewDataSource,UITableViewDelegate {
    public var idQuestion:Int = 0
    public var Question:String = ""
    public var options: NSMutableArray=[]
    @IBAction func buttonFinishClick(_ sender: Any) {
    }
    @IBOutlet var buttonFinish: UIButton!
    @IBOutlet var tableViewOptions: UITableView!
    @IBOutlet var labelQuestion: UILabel!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(tableView.numberOfRows(inSection: 0))
        let cell = self.tableViewOptions.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonCell
        cell.labelQuestion.text = options[indexPath.row] as? String
        return cell
    }
    override func viewDidLoad() {
        tableViewOptions.delegate = self
        tableViewOptions.dataSource = self;
        labelQuestion.text = Question
    }
    
}
