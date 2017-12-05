//
//  UserDataModel.swift
//  SnowRide
//
//  Created by djchai on 11/15/17.
//  Copyright © 2017 newLab. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let userName: String // "pwong"
    let phone: Int //5555555555
    
    let firstName: String // "firstName"
    let lastName: String // "lastName"
    let email: String // "phyllis@gmail.com"
    
    let password: String // "password"
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case id = "_id"
        case userName
        case phone
        
        case firstName
        case lastName
        case email
        
        case password
    }
    
    init(from decoder: Decoder) throws {
        // let container = try decoder.container(keyedBy: TripKeys.self)
        let container = try decoder.container(keyedBy: UserKeys.self)
        let userID: String =  try container.decode(String.self, forKey: .id)
        
        let userName: String = try container.decode(String.self, forKey: .userName)
        let phone: Int = try container.decode(Int.self, forKey: .phone)
        
        let firstName: String = try container.decode(String.self, forKey: .firstName)
        let lastName: String = try container.decode(String.self, forKey: .lastName)
        let email: String = try container.decode(String.self, forKey: .email)
        
        let password: String = try container.decode(String.self, forKey: .password)
        
        self.init(id: userID, userName: userName, phone: phone, firstName: firstName, lastName: lastName, email: email, password: password)
    }
}



extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserKeys.self)
        try container.encode(userName, forKey: UserKeys.userName)
        try container.encode(phone, forKey: UserKeys.phone)
        
        try container.encode(firstName, forKey: UserKeys.firstName)
        try container.encode(lastName, forKey: UserKeys.lastName)
        try container.encode(email, forKey: UserKeys.email)
        
        try container.encode(password, forKey: UserKeys.password)
    }
}
