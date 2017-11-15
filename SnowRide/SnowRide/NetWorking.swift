//
//  NetWorking.swift
//  product-hunt
//
//  Created by djchai on 11/1/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

/*
 Parts of the HTTP Request
 1. Request Method: GET, PUT, DELETE or POST
 2. Header
 3. URL Path
 4. URL Parameters
 5. Body
 */

// #1
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Resource {
    case createUser
    case authUser
    case editUser
    case createTrip
    case getTrip
    case editTrip
    case deleteTrip
    
    // #1
    func httpMethod() -> HTTPMethod {
        switch self {
        case .createUser, .createTrip:
            return .post
        case .authUser, .getTrip:
            return .get
        case .editUser, .editTrip:
            return .put
        case .deleteTrip:
            return .delete
        }
    }
    
    // #2
    func header(token: String) -> [String: String] {
        switch self {
        case .authUser, .getTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(token)",
                    "Host": "" // need api address
                ]
        case .createUser, .createTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(token)",
                "Host": "" // need api address
            ]
        case .editUser, .editTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(token)",
                "Host": "" // need api address
            ]
        case .deleteTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(token)",
                "Host": "" // need api address
            ]
        }
    }
    
    // #3
    func path() -> String {
        switch self {
        case .createUser, .authUser, .editUser:
            return "/users" // need API address for users
        case .createTrip, .getTrip, .editTrip:
            return "/trips" // need API address for trips
        case .deleteTrip:
            return "/trips"
        }
    }
    
    // #4
    func urlParameters() -> [String: String] {
        switch self {
        case .createUser, .authUser, .editUser:
            return [:]
        case .createTrip, .getTrip, .editTrip:
            return [:]
        case .deleteTrip:
            return [:]
        }
    }
    
    // #5
    func body() -> Data? {
        switch self {
        case .createUser, .authUser, .editUser:
            return nil
        case .createTrip, .getTrip, .editTrip:
            return nil
        case .deleteTrip:
            return nil
        }
    }
}


class Networking {
    let session = URLSession.shared
    let baseURL = "http://localhost:3000" // need API address
    
    func fetch(resource: Resource, completion: @escaping ([Decodable]) -> ()) {
        let fullURL = baseURL + resource.path()
        var item = NSURLQueryItem()
       
        
        let componets = NSURLComponents(string: fullURL)
        for (key, value) in resource.urlParameters() {
            item = NSURLQueryItem(name: key, value: value)
        }
        
        componets?.queryItems = [item as URLQueryItem]
        
        let url = componets?.url
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = resource.header(token: "") // need token
        request.httpMethod = resource.httpMethod().rawValue
        
        session.dataTask(with: request) { (data, res, err) in
            if let data = data {
                switch resource {
                case .createUser, .createTrip:
                    print("POST request \(data)")
                case .editUser, .editTrip:
                    print("PATCH request \(data)")
                case .authUser, .getTrip:
                    print("GET request \(data)")
                    
                    let tripList = try? JSONDecoder().decode(TripsList.self, from: data)
                    guard let trips = tripList?.trips else { return }
                    print("do something")
                    return completion(trips)
                    
                case .deleteTrip:
                    print("DELETE request \(data)")
                }
            }
        }.resume()
    }
}




















