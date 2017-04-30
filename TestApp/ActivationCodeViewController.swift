//
//  ActivationCodeViewController.swift
//  TestApp
//
//  Created by Vahagn Gevorgyan on 4/30/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import Alamofire

class ActivationCodeViewController: UIViewController {
    
    var myTextField: UITextField = UITextField()
    var userID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        let button = UIButton()
        button.frame = CGRect(x: 100.0, y: 200.0, width: 200.0, height: 100.0)
        button.backgroundColor = UIColor.green
        button.setTitle("Name your Button ", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        
         myTextField = UITextField(frame: CGRect(x: 0, y: 100, width: 300.00, height: 50.00));
        
        // Or you can position UITextField in the center of the view
       // myTextField.center = self.view.center
        
        // Set UITextField placeholder text
        myTextField.placeholder = "Place holder text"
        
        // Set UITextField border style
        myTextField.borderStyle = UITextBorderStyle.line
        
        // Set UITextField background colour
        myTextField.backgroundColor = UIColor.white
        
        // Set UITextField text color
        myTextField.textColor = UIColor.blue
        
        
        // Add UITextField as a subview
        self.view.addSubview(myTextField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func buttonAction(sender: UIButton!) {
        request3()
    }
    

    func request3()
    {
        // 59048585a82c6f7b2b121208
        let parameters: Parameters = [
            "userId": userID,
            "code": myTextField.text!,
            
            ]
        
        
        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {response in debugPrint(response)
                
                if response.result.value != nil {
                    print("333333333333333333", response)
                    
//                    UserDefaults.standard.set(newValue, forKey: "token")
//                    UserDefaults.standard.synchronize()
        
                    
                                       
                    
                    let viewController = ProfileViewController()
                    
                    self.present(viewController, animated: true, completion: nil)
                }
                print(response)
        }
    }

}
