//
//  CreateTripVC.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

protocol CreateTripDelegate: class {
    func didCreateTrip(trip: Trip)
}

class CreateTripVC: UIViewController {
    
    let newTrip: [Trip] = []
    
    var selectedDepartsOnDate: Trip?
    var selectedReturnsOnDate: Trip?
    weak var delegate: CreateTripDelegate? = nil
    
    

    @IBOutlet weak var departsOnTxt: UITextField!
    @IBOutlet weak var returnsOnTxt: UITextField!
    
    let departsOnDatePicker = UIDatePicker()
    let returnsOnDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDepartOnsPicker()
        createReturnOnPicker()
    }

    func createDepartOnsPicker() {
        
        // format for picker
        departsOnDatePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didPressDone))
        toolbar.setItems([doneButton], animated: false)

        departsOnTxt.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        departsOnTxt.inputView = departsOnDatePicker
        
    }
    
    func createReturnOnPicker() {
        
        // format for picker
        returnsOnDatePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(didPressDone))
        toolbar.setItems([doneButton], animated: false)
        
        returnsOnTxt.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        returnsOnTxt.inputView = returnsOnDatePicker
        
    }
    
    @objc func didPressDone() {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        if departsOnTxt.isEditing {
            departsOnTxt.text = dateFormatter.string(from: departsOnDatePicker.date)
        } else if returnsOnTxt.isEditing {
            returnsOnTxt.text = dateFormatter.string(from: returnsOnDatePicker.date)
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
