//  LoginVC.swift
//  SnowRide
//
//  Created by Phyllis Wong on 10/24/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit



class LoginVC: UIViewController  {
    //variables

    let userDefaults = UserDefaults()
    
    //outlets
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    
    //actions

    
    @IBAction func loginButton(_ sender: Any) {
        loginUser()
    }
    
    
    @IBAction func signupButton(_ sender: Any) {
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? TripsTableVC
        
        // Pass the selected object to the new view controller.
    }
    
    
    func loginUser() {
        let phoneNum:Int? = Int(phoneTF.text!)
        let user = User(username: usernameTF.text!, phone: phoneNum ?? 5555555555)
        
        let networking = Networking()
        print("User from login\(user)")
        // http GET request
        networking.fetch(resource: Resource.authUser) { (result) in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    print("DispatchQueue: \(data!)")
                    self.navigateToProfileView(user: user)
                case let .failure(message):
                    print("Failed message: \(message)")
                    self.navigateToProfileView(user: user)
                }
            }
        }
    }
    
    
    func navigateToProfileView(user: User) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.user = user
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        matchDates()
        self.usernameTF.delegate = self
        self.phoneTF.delegate = self
    }
    
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // hide the keyboard when user touches outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


