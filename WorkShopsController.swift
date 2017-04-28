//
//  WorkShopsController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 17.04.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation
import UIKit
class WorkShopsController : UIViewController,  UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
    var names: NSMutableArray=[]
    var time: NSMutableArray=[]
    var places: NSMutableArray=[]
    var images: NSMutableArray=[]
    var workshops: NSMutableArray=[]
    var desc: NSMutableArray=[]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        
    }
    override func viewDidLoad() {
         get_list_of_workshops(url: "http://yapp.azurewebsites.net/api/lectures")
       
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.bounces = true
        tableView.isScrollEnabled = true
    }
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("OK")
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "workshopCell", for: indexPath) as! CustomCell
        cell.label_Name.text = names[indexPath.row] as? String;
        //cell.label_time.text = time[indexPath.row] as? String;
        //cell.label_Place.text = places[indexPath.row] as? String;
       // cell.label_WorkshopName.text = workshops[indexPath.row] as? String;
        cell.imageViewPhoto.image = UIImage(named: images[indexPath.row] as! String);
        
        return cell
    }
    
    func get_list_of_workshops(url:String)  {
        
        
        
        
        var request = URLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "GET"
        var responseString = ""
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            print("responseString =))) \(responseString)")
            DispatchQueue.main.async {
                
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                        print (convertedJsonIntoDict.count)
                        for i in 0...convertedJsonIntoDict.count-1 {
                            let info = convertedJsonIntoDict[i] as! NSDictionary
                            //self.names.add(info["Speaker"] as! String)
                            self.names.add(info["Topic_en"] as! String)
                            self.desc.add(info["Topic_en"] as! String)
                            self.images.add("i-2.jpeg")
                            print(self.names.count)
                        }
                        
                    }
                    
                    
                }
                    
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                    
                }
                self.tableView.reloadData()
                
                
                
            }
            
        }
        
        
        
        task.resume()
    }


    
}
