//
//  TripsTableVC.swift
//  SnowRide
//
//  Created by Phyllis Wong on 11/8/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import Foundation


struct TripsList: Decodable {
    let trips: [Trip]
}

// Data structure to display in each tableViewCell
struct Trip {
    let id: String
    var departsOn: String //{
//        get {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .long
//            formatter.timeStyle = .none
//            return formatter.string(from: self.departsOnDate)
//        }
//    }
    
//    let departsOnDate: Date
    
    var returnsOn: String //{
//        get {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .long
//            formatter.timeStyle = .none
//            return formatter.string(from: self.returnsOnDate)
//        }
//    }
    
//    let returnsOnDate: Date
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
        let tripID: String = try container.decode(String.self, forKey: .id)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let departsOn: String = try container.decode(String.self, forKey: .departsOn)
        let returnsOn: String = try container.decode(String.self, forKey: .returnsOn)
        let splitDepartsOn = departsOn.split(separator: "T")
        print(String(splitDepartsOn[0]))
        let splitReturnsOn = returnsOn.split(separator: "T")
        
        
        let formatter = ISO8601DateFormatter()
        
//        let departsOnDate = formatter.date(from: departsOn) ?? Date()
//        let returnsOnDate = formatter.date(from: returnsOn) ?? Date()
        
//        let departsOnString = dateFormatter.string(from: departsOnDate)
//        let returnsOnString = dateFormatter.string(from: returnsOnDate)
        
        self.init(id: tripID, departsOn: String(splitDepartsOn[0]), returnsOn: String(splitReturnsOn[0]))
    }
}

extension Trip: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TripKeys.self)
        try container.encode(departsOn, forKey: TripKeys.departsOn)
        try container.encode(returnsOn, forKey: TripKeys.returnsOn)
    }
}







