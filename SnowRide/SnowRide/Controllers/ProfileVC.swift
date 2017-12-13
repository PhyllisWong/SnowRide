//
//  ProfileVC.swift
//  SnowRide
//
//  Created by Phyllis Wong on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import Foundation
import UIKit


class ProfileVC: UIViewController {
    
    var user : User? = nil
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBAction func didPressTrips(_ sender: Any) {
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.user?.username
        self.usernameLabel.text = user?.username
    }
}
