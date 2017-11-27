//
//  TripsTableVC.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import UIKit

class TripsTableVC: UITableViewController {

    var tripsList = [Trip]()
    
    // code to make the add trip nav bar button go to the CreateTripVC
    @IBAction func didPressAdd(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let networking = Networking()
        networking.fetch(resource: .getTrip) { (result) in
            
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                    guard let list = model as? TripsList else {return}
                    self.tripsList = list.trips
                    self.tableView.reloadData()
//                    print("This should show some shit")
                }
            case let .failure(message):
                print(message)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("View loaded")
        self.title = "Snow Ride Trips"
        
        // set the row height for the tableView large enough to display all the data
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 120
        

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
 
   
    // FIX THIS FUNCTION!!!!!
    // Override to support deleting a row the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
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
