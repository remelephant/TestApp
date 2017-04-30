//
//  PhonNumberViewController.swift
//  TestApp
//
//  Created by Vahagn Gevorgyan on 4/30/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import Alamofire

class PhonNumberViewController: UIViewController {

    var phoneNumber: String = ""
    var userID: String = ""
    var myTextField: UITextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        createPhoneLabel()
        createPhoneNumberTextfield()
        createVerifyButton()
        
    }
    
    func createPhoneLabel()
    {
        let label = UILabel(frame: CGRect(x: 30, y: 50, width: view.frame.width - 60, height: 50))
        label.textAlignment = .left
        label.text = "Phone Number:"
        self.view.addSubview(label)
    }
    
    func createPhoneNumberTextfield()
    {
        myTextField = UITextField(frame: CGRect(x: 40, y: 100, width: view.frame.width - 80, height: 50));
        myTextField.placeholder = "Add phone Number"
       // myTextField.borderStyle = UITextBorderStyle.line
        myTextField.backgroundColor = UIColor.white
        myTextField.textColor = UIColor.blue
        myTextField.keyboardType = UIKeyboardType.namePhonePad
        
        self.view.addSubview(myTextField)
    }
    
    func createVerifyButton()
    {
        let verifyButton = UIButton()
        verifyButton.frame = CGRect(x: 30, y: 170, width: view.frame.width - 60, height: 50)
        verifyButton.backgroundColor = UIColor.gray
        verifyButton.titleLabel?.textColor = UIColor.white
        verifyButton.layer.cornerRadius = 5
        verifyButton.setTitle("Send Verification Code ", for: .normal)
        verifyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(verifyButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
        sendVierficationRequest(userID: userID, phoneNumber: myTextField.text!)
    }
    

    func sendVierficationRequest(userID: String, phoneNumber: String)
    {
        // 59048585a82c6f7b2b121208
        let parameters: Parameters = [
            "userId": userID,
            "phoneNumber": phoneNumber,
            
            ]
        
        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/sendcode", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {response in debugPrint(response)
                
                if response.result.value != nil {
                    //                    let json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    //                    print("json", json)
                    
                    print("22222222222222222222222222",response)
                    let viewController = ActivationCodeViewController()
                    viewController.userID = self.userID
                    
                    self.present(viewController, animated: true, completion: nil)
                   // self.request3()
                }
                //                print(response)
        }
    }


}
