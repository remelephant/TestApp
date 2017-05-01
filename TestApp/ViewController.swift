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
    
    var facebookTocken: String!
    var firstName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFacebookLoginButton()
     
        if FBSDKAccessToken.current() != nil {
            facebookTocken = FBSDKAccessToken.current().tokenString
            facebookGraphRequest()
            if firstName != nil {
                if UserDefaults.value(forKey: firstName) != nil {
                    logInAsExistingUser()
                }
            }
        } else {
            print("Log in failed")
        }
        
    }
    
    func createFacebookLoginButton() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: view.frame.height - 100, width: view.frame.width - 32, height:  50)
        loginButton.delegate = self
    }
    
    func logInAsExistingUser() {
        print("Loged in with existing account")
        let viewController = ContactsListViewController()
        self.present(viewController, animated: true, completion: nil)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        self.viewDidLoad()
        print("didCompleteWith")
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        print("loginButtonWillLogin")
        return true
    }
    
    func facebookVarivicationRequest(firstName: String,lastName: String, token: String, fbID: String) {
        
        DispatchQueue.global(qos: .background).async {
            
        let parameters: Parameters = [
            "facebookId": fbID,
            "facebookToken": token,
            "firstName": firstName,
            "lastName": lastName,
            ]
        
        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/new", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in debugPrint(response)
                if response.result.value != nil {
                    
                    let json = response.result.value as! NSDictionary
                    let data = json.value(forKey: "data") as! NSDictionary
                    let impData = data.value(forKey: "user") as! NSDictionary
                    let facebookID = impData.value(forKey: "serverId") as! String
                    let firstName = impData.value(forKey: "serverId") as! String
                    
                    let viewController = PhonNumberViewController()
                    viewController.facebookID = facebookID
                    viewController.firstName = firstName
                    
                    DispatchQueue.main.async {
                        self.present(viewController, animated: true, completion: nil)
                    }
                    
                } else {
                    print("false")
                }
        }
        } // queue
    }
    
    func facebookGraphRequest() {
        DispatchQueue.global(qos: .background).async {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                
                let fbDetails = result as! NSDictionary
                let facebookID = fbDetails.value(forKey: "id") as? String
                let userLastName = fbDetails.value(forKey: "last_name") as! String
                let userFirstName = fbDetails.value(forKey: "first_name") as! String
                
                DispatchQueue.main.async {
                    self.facebookVarivicationRequest(firstName: userFirstName, lastName: userLastName, token: self.facebookTocken, fbID: facebookID!)
                }
            } else {
                print(error?.localizedDescription ?? "Not found")
            }
        })

        } // queue
    }
    
}


