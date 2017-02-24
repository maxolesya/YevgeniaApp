//
//  JSONStuff.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 17.02.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation

class JSONStuff  {
   
    func get_list_of_lectures(url:String) -> [String] {
        
        
       let array = [""]
        var request = URLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "GET"
        
        var responseString = "knlkm";
        
        
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
            
            
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    // Get value by key
                    let firstNameValue = convertedJsonIntoDict["base"] as? String
                    print(firstNameValue!)
                    responseString = firstNameValue!;
                   
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
       
        DispatchQueue.main.async {
            task.resume()
        }
         print("РАБОТАЕТ!!!!!",responseString)
        return array
    }
}
