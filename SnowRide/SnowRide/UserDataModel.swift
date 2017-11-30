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
    let firstName: String // "firstName"
    let lastName: String // "lastName"
    let userName: String // "pwong"
    let password: String // "password"
    let email: String // "phyllis@gmail.com"
    let phone: Int //5555555555
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case userName
        case password
        case email
        case phone
    }
    
    init(from decoder: Decoder) throws {
        // let container = try decoder.container(keyedBy: TripKeys.self)
        let container = try decoder.container(keyedBy: UserKeys.self)
        let userID: String =  try container.decode(String.self, forKey: .id)
        
        let firstName: String = try container.decode(String.self, forKey: .firstName)
        let lastName: String = try container.decode(String.self, forKey: .lastName)
        let userName: String = try container.decode(String.self, forKey: .userName)
        let password: String = try container.decode(String.self, forKey: .password)
        let email: String = try container.decode(String.self, forKey: .email)
        let phone: Int = try container.decode(Int.self, forKey: .phone)
        
        self.init(id: userID, firstName: firstName, lastName: lastName, userName: userName, password: password, email: email, phone: phone)
    }
}

extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserKeys.self)
        try container.encode(firstName, forKey: UserKeys.firstName)
        try container.encode(lastName, forKey: UserKeys.lastName)
        try container.encode(userName, forKey: UserKeys.userName)
        try container.encode(password, forKey: UserKeys.password)
        try container.encode(email, forKey: UserKeys.email)
        try container.encode(phone, forKey: UserKeys.phone)
    }
}
