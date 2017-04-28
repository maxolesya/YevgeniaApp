//
//  RootPageViewController.swift
//  YevgeniaApp
//
//  Created by Олеся Максакова on 27.04.17.
//  Copyright © 2017 HSEProject. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
      var id:String = ""
    lazy var viewControllerList:[UIViewController] = {
      
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "VotingAnswers")
        let vc2 = sb.instantiateViewController(withIdentifier: "VotingAnswers")
        return [vc1,vc2]
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        getOptions(workshopId: "1")
        self.dataSource = self;
        if let firstVC = viewControllerList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex>=0 else {
            return nil
            
        }
        guard viewControllerList.count>previousIndex else{return nil }
        return viewControllerList[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard nextIndex<viewControllerList.count else {
            return nil
            
        }

         return viewControllerList[nextIndex]
    }
    func getOptions(workshopId: String) {
        var request = URLRequest(url: NSURL(string: "http://yapp.azurewebsites.net/api/lectures/"+workshopId+"/voting")! as URL)
       // var request = URLRequest(url: NSURL(string: "http://yapp.azurewebsites.net/api/lectures")! as URL)
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
                 let sb = UIStoryboard(name: "Main", bundle: nil)
                
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                        print (convertedJsonIntoDict.count)
                        for i in 0...convertedJsonIntoDict.count-1 {
                            let info = convertedJsonIntoDict[i] as! NSDictionary
                           // let data : NSData = try!
                            let vc1 = sb.instantiateViewController(withIdentifier: "VotingAnswers") as! VotingAnswersController
                            vc1.Question = info["text"] as! String
                            let optionsArr = info["options"] as! NSArray
                            for j in 0...optionsArr.count-1{
                                let opt = optionsArr[j] as! NSDictionary
                                vc1.options.add(opt["text"] as! String)
                            }
                           
                            
                            vc1.idQuestion = info["id_q"] as! Int
                        
                            self.viewControllerList.append(vc1);
                           
                            
                        }
                        
                    }
                                                
                }
                    
                    
                    
                catch let error as NSError {
                    print(error.localizedDescription)
                    
                }
               
                
                
                
            }
            
        }
        
        
        
        task.resume()

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
