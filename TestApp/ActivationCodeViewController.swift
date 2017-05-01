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
    var facebookID: String!
    var firstName: String!

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
    

    func sendVerificationCodetoBE() {
        DispatchQueue.global(qos: .background).async {
        let parameters: Parameters = [
            "userId": facebookID,
            "code": textField.text!,
            ]
        
        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {response in debugPrint(response)
                
                if response.result.value != nil {
                    
                    let json = response.result.value as! NSDictionary
                    if let data = json.value(forKey: "data") as? NSDictionary {
                        let allTokens = data.value(forKey: "tokens") as! NSDictionary
                        let jwt = allTokens.value(forKey: "jwt") as! String
                        let token = "Bearer \(jwt)"
                        
                        UserDefaults.standard.set(token, forKey: self.firstName)
                        UserDefaults.standard.synchronize()
                    
                    } else {
                        //popup
                    }
                    // for example only (must b moved to line 73)
                    let viewController = ContactsListViewController()
                    viewController.firstName = self.firstName
                    DispatchQueue.main.async {
                    self.present(viewController, animated: true, completion: nil)
                    }
                }
        }
    }// Global queue
    }

}
