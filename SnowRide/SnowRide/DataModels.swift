//
//  Model.swift
//  SnowRide
//
//  Created by Johnathan Chen on 10/25/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import Foundation


struct Trip {
    let departsOn: String
    let returnsOn: String
//    let departsAt: timeval32
    let userID: Int
    let passenger: String?
    let driver: String?
}

struct user {
    let user: String
    let userID: Int
    let phoneNum: Int //5555555555
}

//let passengerAvailability = TripDate(departureDate: "01", returnDate: "02")
//let driverAvailability = TripDate(departureDate: "01", returnDate: "02")

//func matchDates() {
//    if passengerAvailability.departureDate ==  driverAvailability.departureDate {
//        if passengerAvailability.returnDate == driverAvailability.returnDate {
//            print("pass")
//        }
//    }
//}




