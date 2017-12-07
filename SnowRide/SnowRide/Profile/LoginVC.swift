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
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        matchDates()
        self.usernameTF.delegate = (self as? UITextFieldDelegate)
        self.phoneTF.delegate = (self as! UITextFieldDelegate)
    }
    
    
    //actions

    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
    }
    
    // hide the keyboard when user touches outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //func
//    func login(){
//        guard let email = email.text else {
//            print("email issue")
//            return
//        }
//        guard let phonenum = phonenum.text else{
//            print("invalid phone number entry")
//            return
//        }
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
    
    func signup(username: usernameTF.text, phone: phoneTF.text) {
        guard let username = username else { return }
        guard let phone = phone else { return }
        
        let user = User(username: username, phone: phone)
        
        let networking = Networking()
        
        networking.fetch(resource: <#T##Resource#>, completion: <#T##(TripNetworkResult) -> ()#>)
        
    }


