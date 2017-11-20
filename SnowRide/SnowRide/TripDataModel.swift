//
//  TripsTableVC.swift
//  SnowRide
//
//  Created by djchai on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import Foundation


struct TripsList: Decodable {
    let trips: [Trip]
}

// Data structure to display in each tableViewCell
struct Trip {
    var tripID: String
    var departsOn: String
    var returnsOn: String
}

// Extend the Trip struct to convert json to swift naming convention
extension Trip: Decodable {
    
    enum TripKeys: String, CodingKey {
        case id = "_id"
        case departsOn
        case returnsOn
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TripKeys.self)
        let tripID: String = try container.decodeIfPresent(String.self, forKey: .id) ?? "No id"
        let departsOn: String = try container.decodeIfPresent(String.self, forKey: .departsOn) ?? "No departure date"
        let returnsOn: String = try container.decodeIfPresent(String.self, forKey: .returnsOn) ?? "No return date"
        
        self.init(tripID: tripID, departsOn: departsOn, returnsOn: returnsOn)
    }
}

struct user {
    let user: String
    let userID: Int
    let phoneNum: Int //5555555555
}






