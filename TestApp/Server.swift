//
//  Server.swift
//  TestApp
//
//  Created by Vahagn Gevorgyan on 5/1/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Alamofire

struct fbData {
    var fbLastName: String!
    var fbFirstName: String!
    var fbToken: String!
    var fbUserID: String!
    var phoneNumber: String!
    var vericicationCode: String!
    var tokenBA: String!
}

class Server {
    
    var data = fbData()
//    private var fbLastName: String! = data
//    private var fbFirstName: String!
//    private var fbToken: String!
//    private var fbUserID: String!
//    private var phoneNumber: String!
//    private var vericicationCode: String!
//    private var tokenBA: String!
//    
    init() {
            doGraphRequest()
    }
    
    private func doGraphRequest() {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                let fbDetails = result as! NSDictionary
                let userLastName = fbDetails.value(forKey: "last_name") as! String
                let userFirstName = fbDetails.value(forKey: "last_name") as! String
                
                self.data.fbLastName = userLastName
                self.data.fbFirstName = userFirstName
                
            } else {
                print(error?.localizedDescription ?? "Not found")
            }
        })
    }
    
    func getFBTokenAndID() {
        if FBSDKAccessToken.current() != nil  {
            // complation handler for safety
            self.data.fbUserID = FBSDKAccessToken.current().userID
            print("////// ///// //// /////// /////// /////",self.data.fbUserID)
            self.data.fbToken = FBSDKAccessToken.current().tokenString
//            doGraphRequest()
        }
        print(self.data.fbToken)
    }
    
    func setPhoneNumber(number: String) {
        self.data.phoneNumber = number
    }
    
    func containsUserID(array: [String]) -> Bool {
        if array.contains(self.data.fbUserID) {
            return true
        } else {
            return false
        }
    }
    
    private func facebookVarivicationRequest(firstName: String,lastName: String, token: String, fbID: String) {
        
        DispatchQueue.global(qos: .background).async {
            let parameters: Parameters = [
                "facebookId": fbID,
                "facebookToken": token,
                "firstName": firstName,
                "lastName": lastName
                ]
            
            Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/new", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                .responseJSON { response in debugPrint(response)
                    if response.result.value != nil {
                        
//                        let json = response.result.value as! NSDictionary
//                        let data = json.value(forKey: "data") as! NSDictionary
//                        let impData = data.value(forKey: "user") as! NSDictionary
//                        let facebookID = impData.value(forKey: "serverId") as! String
                    } else {
                        print("false")
                    }
            }
        }
    }
    
    func requestVerificationCode() {
        DispatchQueue.global(qos: .background).async {
            let parameters: Parameters = [
                "userId": self.data.fbUserID,
                "phoneNumber": self.data.phoneNumber,
                ]
            
            Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/sendcode", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                .responseJSON {response in debugPrint(response)
                    
                    if response.result.value != nil {
                        print("response")
                    } else {
                        print("error")
                    }
            }
        }
    }
    
//    func sendVerificationCodetoBE() {
//        DispatchQueue.global(qos: .background).async {
//            let parameters: Parameters = [
//                "userId": self.fbUserID,
//                "code": self.vericicationCode
//                ]
//            
//            Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
//                .responseJSON {response in debugPrint(response)
//                    
//                    if response.result.value != nil {
//                        let json = response.result.value as! NSDictionary
//                        if let data = json.value(forKey: "data") as? NSDictionary {
//                            let allTokens = data.value(forKey: "tokens") as! NSDictionary
//                            let jwt = allTokens.value(forKey: "jwt") as! String
//                            self.tokenBA = "Bearer \(jwt)"
//                            } else {
//                                //popup
//                            }
//                    }
//            }
//        }
//    }
    
}
