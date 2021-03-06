//
//  NetWorking.swift
//  product-hunt
//
//  Created by Phyllis Wong on 11/1/17.
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
    case createUser(model: Encodable)
    case authUser
    case editUser(model: Encodable)
    case createTrip(departsOn: String, returnsOn: String)
    case getTrip
    case editTrip(model: Encodable)
    case deleteTrip(tripID: String)
    
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
            return [" ": "application/json",
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
            return "/users"
        case .createTrip, .getTrip, .editTrip:
            return "/trips"
        case let .deleteTrip(tripID):
            return "/trips/\(tripID)"
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
        // post requests
        case let .createTrip(departsOn, returnsOn):
            
            let trip = Trip(id: "", departsOn: departsOn, returnsOn: returnsOn)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            print(trip)
            // jsonObject with date encoded to UNIX timestamp
            let data = try? encoder.encode(trip)
            return data
            
        case .createUser:
            return nil
        // get requests
        case .authUser, .getTrip:
            return nil
        case .editUser:
            return nil
        case.editTrip:
            return nil
        case .deleteTrip:
            return nil
        }
    }
}

enum TripNetworkResult {
    case success(data: Decodable?)
    case failure(message: String)
}


class Networking {
    let session = URLSession.shared
    let baseURL = "http://localhost:3000" // local server...still need API url
    
    func filterSuccessCode(statusCode: Int) -> Bool {
        let range = 200...299
        return range.contains(statusCode)
    }
    
    func fetch(resource: Resource, completion: @escaping (TripNetworkResult) -> ()) {
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
        request.httpBody = resource.body()
        
        session.dataTask(with: request) { (data, response, err) in
            //
            guard let response = response as? HTTPURLResponse, self.filterSuccessCode(statusCode: response.statusCode) == true else { return completion(TripNetworkResult.failure(message:
                "Was not succesful"))
            }
            
            // Successful response
            switch resource {
            case .createUser, .createTrip, .deleteTrip:
                return completion(TripNetworkResult.success(data: nil))
            case .editUser, .editTrip:
                return completion(TripNetworkResult.success(data: nil))
            case .authUser, .getTrip:
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let data = data, let tripList = try? decoder.decode(TripsList.self, from: data)
                    else {return completion(TripNetworkResult.failure(message: "Could not decode model"))}
                
                return completion(TripNetworkResult.success(data: tripList))
            }
        }.resume()
    }
}




















