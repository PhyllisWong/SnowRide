//  LoginVC.swift
//  SnowRide
//
//  Created by Johnathan Chen on 10/24/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit



class LoginVC: UIViewController  {
    //variables

    
    //outlets

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phonenum: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        matchDates()

    }
    
    
    //actions
    @IBAction func login(_ sender: Any) {
    }
    
    @IBAction func register(_ sender: Any) {
    }
    
    @IBAction func login_or_register(_ sender: Any) {
    }
    
    //func
    func login(){
        guard let email = email.text else {
            print("email issue")
            return
        }
        guard let phonenum = phonenum.text else{
            print("invalid phone number entry")
            return
        }
//        Auth.auth().signIn(withEmail: email, password: phonenum, completion: { (user, err) in
//                if err != nil{
//                    print("not signed in")
//                    print(err!)
//                    return
//                }
//                print("signed in")
//                self.dismiss(animated: true, completion: nil)
//        })
    }
    
    func signup(){
        guard let username = username.text else{
            print("username issue")
            return
        }
        guard let email = email.text else{
            print("email issue")
            return
        }
        guard let phonenum = phonenum.text else{
            print("phonenum issue")
            return
        }
//        Auth.auth().createUser(withEmail: email, password: phonenum, completion: { (user, err) in
//            if err != nil { print(err!); return }
//
//            guard let id = user?.uid else{ return }
//
//            let userReference = self.databaseRef.child("users").child(id)
//            let values = ["username": username, "email": email, "pic":""]
//
//            userReference.updateChildValues(values
//                , withCompletionBlock: { (error, ref) in
//                    if error != nil{
//                        print(error!)
//                        return
//                    }
//                    self.dismiss(animated: true, completion: nil)
//            })
//
//        })
        
    }
}

