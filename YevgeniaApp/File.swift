//
//  File.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 13.02.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation
class Auth {
    /*func auth(login: String, password: String) -> String {
        
        var message = "";
        var urlString = "";
        let url = URL(string: urlString)
        var request = URLRequest(url:url! as URL);
        print(urlString, url?.absoluteString ?? "+")
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        var responseString = "";
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                message = (error as! String?)!
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
        
        task.resume()

        //27 стр  уч стр 81 инфинитив 82-83 описание графиков
        return message;*/
    func getAnswer(URL:String) -> String {
        let request = NSURLRequest(url: NSURL(string: "http://iswift.org")! as URL)
        var str = "";
        // Perform the request
       
       NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue(), completionHandler:{
            (response: URLResponse?, data: Data?, error: Error?)-> Void in
            
            // Get data as string
            str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                   }
        );
        return str;

    }
       // Perform the request
    
}
