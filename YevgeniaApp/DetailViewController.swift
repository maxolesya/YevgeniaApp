//
//  DetailViewController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 15.02.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController : UIViewController {
    
    @IBOutlet weak var textQuestion: UITextField!
    @IBOutlet weak var labelName: UILabel!
   
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var name = "";
    var desc = "";
    var image = UIImage();
    var array1 = ["",""]
    
     override func viewDidLoad()
    {
        labelName.text = name;
        labelDesc.text = desc;
        imageView.image = image
               super.viewDidLoad()
        
        
    }

    @IBAction func plus_click(_ sender: Any) {
        if !(textQuestion.text?.isEmpty)! {
            post_question(url: "http://yapp.azurewebsites.net/api/ask", question: textQuestion.text!)
            
        }

        
    }
        
       func post_question(url: String, question: String)  {
        var request = URLRequest(url: NSURL(string: url)! as URL)
        
        request.httpMethod = "POST" 
        
        let postString = "question="+question
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil { // обработка ошибки при отправке
                
                print("error=\(error)")
                
                return
                
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("responseString = \(responseString)")
            
        }
        
        task.resume()
        
        
        
    }
    
}
