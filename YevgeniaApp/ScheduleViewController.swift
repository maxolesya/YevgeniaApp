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
    var names: NSMutableArray=[]//["Mark", "Julie", "Pike"]
    var desc: NSMutableArray=[]//["Make-up", "Eyebrows", "Nails"]
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    @IBOutlet weak var scrollView: UIScrollView!
    //var images = [UIImage(named: "i-2.jpeg"),UIImage(named: "i-2.jpeg"),UIImage(named: "i-2.jpeg")];
    var images: NSMutableArray=[]//["i-2.jpeg","i-2.jpeg","i-2.jpeg"]
        @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
       
        get_list_of_lectures(url: "http://yapp.azurewebsites.net/api/get_lectures")
        
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
        print(tableView.numberOfRows(inSection: 0))
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "templateCell", for: indexPath) as! TemplateCell
            cell.photo.image = UIImage(named: images[indexPath.row] as! String);
            cell.labelName.text = names[indexPath.row] as? String;
            cell.labelDesc.text = desc[indexPath.row] as? String
       
            print("ok")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to the second view controller
        self.performSegue(withIdentifier: "detailSegue", sender:names[indexPath.row])
    }
         // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue", let destination = segue.destination as? DetailViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
               destination.name = names[indexPath.row] as! String
                destination.desc = desc[indexPath.row] as! String
                destination.image = UIImage(named: images[indexPath.row] as! String)!
                print(desc[indexPath.row])
            print(destination.desc)}
        }
        // set a variable in the second view controller with the data to pass
           }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if scrollView == self.scrollView {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                tableView.isScrollEnabled = true
            }
        }
        
        if scrollView == self.tableView {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.tableView.isScrollEnabled = false
            }
        }
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
                            self.names.add(info["Speaker"] as! String)
                            self.desc.add(info["Description"] as! String)
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
