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
import FBSDKShareKit
import Foundation


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var facebookTocken: String!
    var serverID: String!
    var facebookID: String!
    var someString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFacebookLoginButton()
     
        if FBSDKAccessToken.current() != nil {
            facebookTocken = FBSDKAccessToken.current().tokenString
            facebookGraphRequest()
            
        } else {
            print("Log in failed, create new account")
        }
        
    }
    
    func createFacebookLoginButton() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: view.frame.height - 100, width: view.frame.width - 32, height:  50)
        loginButton.delegate = self
    }
    
    func logInExistingAsUser() {
        print("Loged in with existing account")
        facebookTocken = FBSDKAccessToken.current().tokenString
        let viewController = ContactsViewController()
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
                    let mainData = data.value(forKey: "user") as! NSDictionary
                    let facebookID = mainData.value(forKey: "serverId") as! String
                    
                    let viewController = PhonNumberViewController()
                    viewController.facebookID = facebookID
                    
                    self.present(viewController, animated: true, completion: nil)
                } else {
                    print("false")
                }
        }
    }
    
    func facebookGraphRequest() {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                
                let fbDetails = result as! NSDictionary
                let facebookID = fbDetails.value(forKey: "id") as? String
                let userLastName = fbDetails.value(forKey: "last_name") as! String
                let userFirstName = fbDetails.value(forKey: "first_name") as! String

                self.facebookVarivicationRequest(firstName: userFirstName, lastName: userLastName, token: self.facebookTocken, fbID: facebookID!)
            } else {
                print(error?.localizedDescription ?? "Not found")
            }
        })

    }
    
}



    
    
//    func requestLast()
//    {
//        
//        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/profile", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJnZW5lcmF0aW9uRGF0ZSI6MTQ5MzU2MTQ3MTUxMywidXNlcklkIjoiNTkwNTJiOTJhODJjNmY3YjJiMTIxMjA5IiwiZmFjZWJvb2tJZCI6IjEwMjAzMjI3OTU2Njk1OTY2IiwicGhvbmVOdW1iZXIiOiI5OTU5NTkwOSIsInZlcnNpb24iOjF9.NIiFLzLPy3o7yhT7wJ9QGE-LPPVEzbRZFHIoGN_Dww4"])
//            .responseJSON {response in debugPrint(response)
//                
//                if response.result.value != nil {
//                    print(response)
//                }
//        }
//    }
//    
//    
//    
//    func fetchProfile() {
////        print("Fetch profile: ", FBSDKAccessToken.current().tokenString)
//    }
//    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        
//
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
////        print("loged out")
//    }
//    
//    public func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
//        return true
//    }
//
//
//
//
//
////    func application(application: UIApplication!, performFetchWithCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
////        loadShows() {
////            completionHandler(UIBackgroundFetchResult.newData)
////            print("Background Fetch Complete")
////        }
////    }
//    
//    
    //
//    func request3()
//    {
//        // 59048585a82c6f7b2b121208
//        let parameters: Parameters = [
//            "userId": "59052b92a82c6f7b2b121209",
//            "code": "12345",
//
//            ]
//
//        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
//            .responseJSON {response in debugPrint(response)
//                
//                if response.result.value != nil {
//                    print("333333333333333333", response)
//                }
//                print(response)
//        }
//    }
//    
//}


