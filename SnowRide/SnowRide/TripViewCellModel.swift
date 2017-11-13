//
//  TripViewCellModel.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import Foundation

// When the date picker is saved, append to the array here!!!
struct tripList {
    var driverList: [Trip] = [
        Trip(departsOn: "01", returnsOn: "02", userID: 1, passenger: nil, driver: "Phyllis"),
        Trip(departsOn: "02", returnsOn: "03", userID: 1, passenger: "Kendra", driver: "Phyllis")
    ]
    
    var passengerList: [Trip] = [
        Trip(departsOn: "01", returnsOn: "02", userID: 2, passenger: "Kendra", driver: nil),
        Trip(departsOn: "02", returnsOn: "03", userID: 2, passenger: "Kendra", driver: "Phyllis")
    ]
}
