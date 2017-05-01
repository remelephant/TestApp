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
    
    var textField: UITextField = UITextField()
    var facebookID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        createVerifyButton()
        verificationCodeTextfield()
    }
    
    func createVerifyButton() {
        let verifyButton = UIButton()
        verifyButton.frame = CGRect(x: 30, y: 170, width: view.frame.width - 60, height: 50)
        verifyButton.backgroundColor = UIColor.gray
        verifyButton.titleLabel?.textColor = UIColor.white
        verifyButton.layer.cornerRadius = 5
        verifyButton.setTitle("Verify", for: .normal)
        verifyButton.addTarget(self, action: #selector(verifyCode), for: .touchUpInside)
        self.view.addSubview(verifyButton)
    }
    
    func verificationCodeTextfield() {
        textField = UITextField(frame: CGRect(x: 40, y: 100, width: view.frame.width - 80, height: 50));
        textField.placeholder = "Add phone Number"
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.blue
        textField.keyboardType = UIKeyboardType.numberPad
        self.view.addSubview(textField)
    }
    
    func verifyCode(sender: UIButton!) {
        sendVerificationCodetoBE()
    }
    

    func sendVerificationCodetoBE()
    {
        let parameters: Parameters = [
            "userId": facebookID,
            "code": textField.text!,
            ]
        
        
        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {response in debugPrint(response)
                
                if response.result.value != nil {
                    
                UserDefaults.standard.set(newValue, forKey: "token")
                UserDefaults.standard.synchronize()
                    
                let viewController = ProfileViewController()
                self.present(viewController, animated: true, completion: nil)
                }
                print(response)
        }
    }

}
