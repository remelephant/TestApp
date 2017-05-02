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

    var myTextField: UITextField = UITextField()
    let validNumbers = ["91","99", "96", "43", "55", "95", "41", "44", "93", "94", "77", "98", "49"]
    let localCode = "+374"
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        createPhoneNumberLabel()
        createPhoneNumberTextfield()
        createVerifyButton()
    }
    
    func createPhoneNumberLabel() {
        let label = UILabel(frame: CGRect(x: 30, y: 50, width: view.frame.width - 60, height: 50))
        label.textAlignment = .left
        label.text = "Phone Number:"
        self.view.addSubview(label)
    }
    
    func createPhoneNumberTextfield() {
        myTextField = UITextField(frame: CGRect(x: 40, y: 100, width: view.frame.width - 80, height: 50));
        myTextField.placeholder = "Add phone number"
        myTextField.backgroundColor = UIColor.white
        myTextField.textColor = UIColor.blue
        myTextField.keyboardType = UIKeyboardType.numberPad
        self.view.addSubview(myTextField)
    }
    
    func createVerifyButton() {
        let verifyButton = UIButton()
        verifyButton.frame = CGRect(x: 30, y: 170, width: view.frame.width - 60, height: 50)
        verifyButton.backgroundColor = UIColor.gray
        verifyButton.titleLabel?.textColor = UIColor.white
        verifyButton.layer.cornerRadius = 5
        verifyButton.setTitle("Send Verification Code ", for: .normal)
        verifyButton.addTarget(self, action: #selector(sendPhoneNumber), for: .touchUpInside)
        //view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(verifyButton)
    }

    func sendPhoneNumber(sender: UIButton!) {
        let phoneNumber = myTextField.text
        let valid = isNumberValid(number: phoneNumber!)
        if valid {
            let fullNumber = "\(localCode)\(phoneNumber!)"
            server.setPhoneNumber(number: fullNumber)
            server.requestVerificationCode()
            let viewController = ActivationCodeViewController()
            self.present(viewController, animated: true, completion: nil)
        } else {
            //Popup or button is not active
            print("The number is not vaild")
        }
    }
    
    func isNumberValid(number: String) -> Bool {
        let prefix = String(number.characters.prefix(2))
        
        if !validNumbers.contains(prefix) { return false }
        if number.characters.count != 8 { return false }
        return true
    }

    


}
