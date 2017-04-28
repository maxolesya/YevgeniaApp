//
//  ViewController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 13.02.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLogin: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    var ticketCode = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func new_send(_ sender: Any) {
        ticketCode = textLogin.text!;
        print("OK")
        post_question(url: "http://yapp.azurewebsites.net/api/auth", ticket: ticketCode)
        
        
    }
    @IBAction func sendCodeClick(_ sender: Any) {
    }
    func post_question(url: String, ticket: String)  {
        var request = URLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "POST"
        
        let postString = "ticket="+ticket
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil { // обработка ошибки при отправке
                return
                
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            if((responseString?.contains("error"))! || (responseString?.contains("unregistered"))!) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Wrong code!", message: "Check your ticket number!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(defaultAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    return}
                
                
            }
            
            print("responseString = \(responseString)")
            
            
        }
        
        task.resume()
        
        
        
    }
    
    @IBAction func sign_up_click(_ sender: Any) {
        auth(url: "http://yapp.azurewebsites.net/api/check_code")
    }
    
    
    
    func auth(url:String)  {
        
        let getString = "?ticket="+ticketCode+"&code="+textPassword.text!;
        var request = URLRequest(url: NSURL(string: url+getString)! as URL)
        request.httpMethod = "GET"
        //request.httpBody = getString.data(using: String.Encoding.utf8)
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
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        
                        
                        print(convertedJsonIntoDict["status"] as! String)
                        if(convertedJsonIntoDict["status"] as! String=="success") {
                            self.performSegue(withIdentifier: "tableViewSegue", sender: self)
                            
                        }
                        else{
                            let alert = UIAlertController(title: "Wrong code!", message: "Check your email and enter right number!", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(defaultAction)
                            
                            self.present(alert, animated: true, completion: nil)}
                        
                    }
                    
                    
                }
                    
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                    
                }
                
                
                
            }
            
        }
        
        
        
        task.resume()
    }
    
    
}

