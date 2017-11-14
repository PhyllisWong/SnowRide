//
//  createTripVC.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class createTripVC: UIViewController {

    @IBOutlet weak var departOnTxt: UITextField!
    @IBOutlet weak var returnOnTxt: UITextField!
    
    let departOnDatePicker = UIDatePicker()
    let returnOnDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDepartOnPicker()
        createReturnOnPicker()
    }

    func createDepartOnPicker() {
        
        // format for picker
        departOnDatePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didPressDone))
        toolbar.setItems([doneButton], animated: false)

        departOnTxt.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        departOnTxt.inputView = departOnDatePicker
        
    }
    
    func createReturnOnPicker() {
        
        // format for picker
        returnOnDatePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didPressDone))
        toolbar.setItems([doneButton], animated: false)
        
        returnOnTxt.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        returnOnTxt.inputView = returnOnDatePicker
        
    }
    
    @objc func didPressDone() {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        if departOnTxt.isEditing {
            departOnTxt.text = dateFormatter.string(from: departOnDatePicker.date)
        } else if returnOnTxt.isEditing {
            returnOnTxt.text = dateFormatter.string(from: returnOnDatePicker.date)
        }
        self.view.endEditing(true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tripsVC = segue.destination as? TripsTableVC
        
        // Pass the selected object to the new view controller.
    }
 

}
