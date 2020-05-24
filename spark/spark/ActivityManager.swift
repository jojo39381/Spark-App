//
//  RestaurantsManager.swift
//  spark
//
//  Created by Joseph Yeh on 5/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

protocol ActivityManagerDelegate {
    func didLoadActivities(data: ActivityModel)
}
struct ActivityManager {
    let activityUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?parameters"
    let API_KEY = "AIzaSyCyOREZ-tMNFbjcpMcye-58009jQlDh1aA"
    
    
    
    
    var delegate: ActivityManagerDelegate?
    var categories: [String:String]
    func fetchActivities() {
        let urlString = activityUrl
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string:urlString) {
            
            
            var components = URLComponents(string: urlString)
            
            components?.queryItems = [
                
               
                URLQueryItem(name: "radius", value: "1500"),
                URLQueryItem(name: "location", value: "-33.8670522,151.1957362"),
                URLQueryItem(name: "key", value: API_KEY),
               
            
            ]
            
            for (key, value) in categories {
                print("bbbbbbbbbbbbbb")
                print(value)
                components?.queryItems?.append(URLQueryItem(name: "type", value: value))

            }
            
            
            var request = URLRequest(url: (components?.url)!)
            let session = URLSession(configuration: .default)
            print(components?.url)
            let task = session.dataTask(with: request, completionHandler: handle(data:response:error:) )
            task.resume()
        }
        
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
//            if let restaurantData = self.parseJSON(restaurantData: safeData) {
//                print("lol")
//
//                print(restaurantData.restaurants)
//
//            }
            
        }
        
    }
    
    func parseJSON(restaurantData: Data) -> ActivityModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: restaurantData)
            var array = [String]()
            var restaurantData = ActivityModel(restaurants:array)
            for business in decodedData.businesses {
                restaurantData.restaurants.append(business.name)
            }
            return restaurantData
        }
        catch {
            print(error)
            return nil
        }
        
    }
    
    
    
    
    
    
    
}
