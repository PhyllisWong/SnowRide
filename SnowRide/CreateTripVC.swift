//
//  TripsTableVC.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit

protocol CreateTripDelegate: class {
    func didCreateTrip(trip: Trip)
}

class CreateTripVC: UIViewController {
    
    var trip: Trip?
    
    var selectedDepartsOnDate: Trip?
    var selectedReturnsOnDate: Trip?
    weak var delegate: CreateTripDelegate? = nil
    
    // Button to send trip data to database
    @IBAction func didPressSaveTrip() {
        
        guard let trip = trip else {return}
        
        let networking = Networking()
        
        // POST request passing in encodable trip
        networking.fetch(resource: .createTrip(model: trip), completion: handleNetworkResult)
        
    }
    
    func handleNetworkResult(result: TripNetworkResult) {
        switch result {
        case .success(_):
            self.navigationController?.popViewController(animated: true)
        case let .failure(message):
            print(message)
        }

    }
    
    // text fields to show the selected dates picked
    @IBOutlet weak var departsOnTxt: UITextField!
    @IBOutlet weak var returnsOnTxt: UITextField!
    
    // Date pickers show when user presses the text field
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
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        
        
        if departsOnTxt.isEditing {
            departsOnTxt.text = dateFormatter.string(from: departsOnDatePicker.date)
            // show date as unix timestamp
            let departsOnTimeStamp = self.departsOnDatePicker.date.timeIntervalSince1970
//            trip.departsOn = departsOnTxt.text!
            print("Departs on text: \(departsOnTxt.text!)")
            print("UNIX timestamp: \(departsOnTimeStamp)")
            
        } else if returnsOnTxt.isEditing {
            returnsOnTxt.text = dateFormatter.string(from: returnsOnDatePicker.date)
            // show date as unix timestamp
            let returnsOnTimeStamp = self.returnsOnDatePicker.date.timeIntervalSince1970
//            trip.returnsOn = returnsOnTxt.text!
            print("Returns on text: \(returnsOnTxt.text!)")
            print("UNIX timestamp: \(returnsOnTimeStamp)")
        }
//        trip.tripID = "1"
        self.view.endEditing(true)
        
        let trip = Trip(departsOn: departsOnTxt.text!, /*departsOnDate: departsOnDatePicker.date,*/ returnsOn: returnsOnTxt.text! /*,returnsOnDate: returnsOnDatePicker.date*/)
        self.trip = trip
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? TripsTableVC
        
        // Pass the selected object to the new view controller.
    }
 

}
