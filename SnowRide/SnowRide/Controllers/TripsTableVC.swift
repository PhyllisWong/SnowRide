//
//  TripsTableVC.swift
//  SnowRide
//
//  Created by Phyllis Wong on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit

class TripsTableVC: UITableViewController {

    var tripsList = [Trip]()
    var selectedTrip: Trip?
    
    // code to make the add trip nav bar button go to the CreateTripVC
    @IBAction func didPressAdd(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // http GET request
        let networking = Networking()
        networking.fetch(resource: .getTrip) { (result) in
            
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                    guard let list = model as? TripsList else {return}
                    self.tripsList = list.trips
                    self.tableView.reloadData()
                }
            case let .failure(message):
                print(message)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 218/255, green: 250/255, blue: 248/255, alpha: 1)
        self.title = "Snow Ride Trips"
        
        // set the row height for the tableView large enough to display all the data
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 120
    }
    
    // When user selects a row in the table view go to the detail view of the trip
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTrip = tripsList[indexPath.row]
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//
//        let tripDetailVC = storyboard.instantiateViewController(withIdentifier: "TripDetailVC") as! TripDetailVC
//
//        tripDetailVC.trip = trip
//        tripDetailVC.user = user
        //        print(tripDetailVC.trip)
//        self.navigationController?.pushViewController(tripDetailVC, animated: true)
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return tripsList.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripViewCell", for: indexPath) as! TripViewCell
        let raw = indexPath.item
        cell.trip = tripsList[raw]
        return cell
    }
    
    // adjusts the height of the tableview
    func tableView(_ tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // Deleting a row the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let deleteTrip = tripsList[indexPath.row]
            
            // Delete data from the array of Trips
            self.tripsList.remove(at: indexPath.row)
            //Delete the row from the tableview
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // http DELETE request to remove from the database
            let networking = Networking()
            networking.fetch(resource: .deleteTrip(tripID: deleteTrip.id)) { (result) in
                
                // Reloads tableview data if successful
                // prints failure message if unsuccessful
                switch result {
                case let .success(model):
                    DispatchQueue.main.async {
                        guard let list = model as? TripsList else {return}
                        self.tripsList = list.trips
                        self.tableView.reloadData()
                    }
                case let .failure(message):
                    print(message)
                }
            }
            
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tripDetailVC = segue.destination as? TripDetailVC else { return }
        tripDetailVC.trip = selectedTrip
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
