//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Vahagn Gevorgyan on 4/30/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        request4()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func request4()
    {
                //        Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJnZW5lcmF0aW9uRGF0ZSI6MTQ5MzIxODY1NDM1NCwidXNlcklkIjoiNThmZjE4MGQwMDViNDAyZGRiNDFlNTQ0IiwiZmFjZWJvb2tJZCI6ImZhY2Vib29rSWQxIiwicGhvbmVOdW1iZXIiOiIrMzczOTM2NDg4ODgiLCJ2ZXJzaW9uIjozfQ.X0iXmsNyJ4QWdQC1ytiZXUH--dcHtHrZ7muFwL4NUUg
        
        Alamofire.request("http://sample-env-2.w6em3jmvdb.us-west-2.elasticbeanstalk.com/user/profile", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJnZW5lcmF0aW9uRGF0ZSI6MTQ5MzU2MTQ3MTUxMywidXNlcklkIjoiNTkwNTJiOTJhODJjNmY3YjJiMTIxMjA5IiwiZmFjZWJvb2tJZCI6IjEwMjAzMjI3OTU2Njk1OTY2IiwicGhvbmVOdW1iZXIiOiI5OTU5NTkwOSIsInZlcnNpb24iOjF9.NIiFLzLPy3o7yhT7wJ9QGE-LPPVEzbRZFHIoGN_Dww4"])
            .responseJSON {response in debugPrint(response)
                
                if response.result.value != nil {
                    print(response)
                }
        }
    }


}
