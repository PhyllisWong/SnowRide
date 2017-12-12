//  LoginVC.swift
//  SnowRide
//
//  Created by Phyllis Wong on 10/24/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit



class LoginVC: UIViewController  {
    //variables

    let user = UserDefaults()
    
    //outlets
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        matchDates()
        self.usernameTF.delegate = self
        self.phoneTF.delegate = self
    }
    
    
    //actions

    
    @IBAction func loginButton(_ sender: Any) {
        let phoneNum:Int? = Int(phoneTF.text!)
        let user = User(username: usernameTF.text!, phone: phoneNum ?? 5555555555)
        
        let networking = Networking()
        print(user)
         // http GET request
        networking.fetch(resource: Resource.authUser) { (result) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let ProfileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    print("DispatchQueue: \(data!)")
                    self.navigationController?.pushViewController(ProfileVC, animated: true)
                }
            case let .failure(message):
                DispatchQueue.main.async {
                    print("Failed message: \(message)")
                    self.navigationController?.pushViewController(ProfileVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? TripsTableVC
        
        // Pass the selected object to the new view controller.
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


