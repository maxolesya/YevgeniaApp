//
//  ScheduleViewController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 15.02.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation
import UIKit
class ScheduleViewConroller : UIViewController, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
    var names: NSMutableArray=[]
    var time: NSMutableArray=[]
    var places: NSMutableArray=[]
    var types: NSMutableArray=[]
    var titles:  NSMutableArray=[]
    var id:NSMutableArray=[]
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    @IBOutlet weak var scrollView: UIScrollView!
    var images: NSMutableArray=[]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        get_list_of_lectures(url: "http://yapp.azurewebsites.net/api/lectures")
        scrollView.delegate = self
        tableView.delegate = self
        scrollView.bounces = true
        tableView.bounces = true
        tableView.isScrollEnabled = true
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "templateCell", for: indexPath) as! TemplateCell
        cell.photo.image = UIImage(named: images[indexPath.row] as! String);
        cell.labelName.text = names[indexPath.row] as? String;
        cell.labelTime.text = time[indexPath.row] as? String;
       // cell.labelPlace.text = places[indexPath.row] as? String;
        cell.labelTitle.text = titles[indexPath.row] as? String;
        cell.labelType.text = types[indexPath.row] as? String;
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("perform")
        // Segue to the second view controller
        if types[indexPath.row] as! String=="lecture" {
        self.performSegue(withIdentifier: "detailSegue", sender:indexPath.row)
        }
        else{
             self.performSegue(withIdentifier: "pageSegue", sender:indexPath.row)
        }
        
    }
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue", let destination = segue.destination as? DetailViewController {
            if let index = sender as? Int {
                destination.name = names[index] as! String
                destination.image = UIImage(named: images[index] as! String)!
                destination.lectureId = id[index] as! String
               }
        }
        if segue.identifier == "pageSegue", let destination = segue.destination as? RootPageViewController{
            if let index = sender as? Int {
                destination.id = id[index] as! String
            }
        }
        // set a variable in the second view controller with the data to pass
    }
    
    
    func get_list_of_lectures(url:String)  {
        
        
        
        
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
            print("responseString = \(responseString)")
            DispatchQueue.main.async {
                
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                        print (convertedJsonIntoDict.count)
                        for i in 0...convertedJsonIntoDict.count-1 {
                            let info = convertedJsonIntoDict[i] as! NSDictionary
                            self.names.add(info["name"] as! String)
                            self.titles.add(info["topic"] as! String);
                            self.types.add(info["event_type"] as! String);
                            self.id.add(info["id"] as! Int);
                            //self.places.add(info["Description"] as! String)
                            self.time.add(info["date_start"] as! String);
                            
                            //var speakerInfo = JSONSerialization.jsonObject(with: y!, options: []) as? NSDictionary
                           //self.names.add(speakerInfo["name"] as! String)
                            
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
