//
//  ViewController.swift
//  TestApp
//
//  Created by Vahagn Gevorgyan on 4/28/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire

//import Foundation


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var server = Server()
    var arrayOfUsers: [String] = [] // This must be saved in core data as dictionarry
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFacebookLoginButton()
    }
    
    func createFacebookLoginButton() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: view.frame.height - 100, width: view.frame.width - 32, height:  50)
        loginButton.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        server.getFBTokenAndID()

        if server.containsUserID(array: arrayOfUsers) {
            let viewController = FinalViewController()
            self.present(viewController, animated: true, completion: nil)
        } else {
            let viewController = PhonNumberViewController()
            self.present(viewController, animated: true, completion: nil)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("loginButtonWillLogin")
        return true
    }
}


