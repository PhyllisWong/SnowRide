//
//  TripDetailVC.swift
//  SnowRide
//
//  Created by djchai on 12/12/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit

class TripDetailVC: UIViewController {
    
    // Variables
    var trip : Trip?
    
    
    // Outlets
    
    @IBOutlet weak var departsOnLabel: UILabel!
    @IBOutlet weak var returnsOnLabel: UILabel!
    
    // Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let departsOn = trip?.departsOn
        let returnsOn = trip?.returnsOn
        
        departsOnLabel.text = departsOn
        returnsOnLabel.text = returnsOn
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
