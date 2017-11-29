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
        
//         remove since these are handled with the getter
        let departsOn: String = try container.decodeIfPresent(String.self, forKey: .departsOn) ?? "No departure date"
        let returnsOn: String = try container.decodeIfPresent(String.self, forKey: .returnsOn) ?? "No return date"
//        
//        let departsOnDate: Date = try container.decode(Date.self, forKey: .departsOn)
//        let returnsOnDate: Date = try container.decode(Date.self, forKey: .returnsOn)
        
        self.init(id: tripID, departsOn: departsOn, /*departsOnDate: departsOnDate,*/ returnsOn: returnsOn)
    }
}

extension Trip: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TripKeys.self)
        try container.encode(departsOn, forKey: TripKeys.departsOn)
        try container.encode(returnsOn, forKey: TripKeys.returnsOn)
    }
}







