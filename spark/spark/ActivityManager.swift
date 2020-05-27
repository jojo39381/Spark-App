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
            
            
            
            
            var latitude = "37.866309"
            var longitude =  "-122.254605"
            var components = URLComponents(string: urlString)
            
            components?.queryItems = [
                
               
                URLQueryItem(name: "radius", value: "30000"),
                URLQueryItem(name: "location", value: latitude + ", " + longitude),
                URLQueryItem(name: "rankby", value: "prominence"),
            
            
                URLQueryItem(name: "key", value: API_KEY)
                
               
            
            ]
            
            
            
            
            
            
            
            for (key, value) in categories {
                print("bbbbbbbbbbbbbb")
                print(value)
                
                


            }
            
            
            var request = URLRequest(url: (components?.url)!)
            let session = URLSession(configuration: .default)
            print(components?.url)
            var count = 0
            var result = [String]()
            for (key, value) in categories {
                components?.queryItems?.append(URLQueryItem(name: "keyword", value: value))
                var request = URLRequest(url: (components?.url)!)
                let task = session.dataTask(with: request) { (data, response, error) in
                    
                    if let safeData = data {
                        if let parsed = self.parseData(restaurantData: safeData) {
                            result += parsed
                        }
                    }
                    
                    do {
                        count += 1
                        if count == self.categories.count {
                            self.handleCompletion(data: result, response: response, error: error)
                        }
                    }
                    
                }
                print(";;;;;;;;;;;;;")
                print(components?.url)
                let count = components?.queryItems?.count
                components?.queryItems?.remove(at: count! - 1)
                task.resume()
            }
            
        }
        
        
    }
    func handleCompletion(data: [String]?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        let model = ActivityModel(restaurants: data!)
        self.delegate?.didLoadActivities(data: model)
        
        
    }
    
    
    
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print("kasbdfkjadbfbkjsb")
            
            if let restaurantData = self.parseJSON(restaurantData: safeData) {
                
            
                print(restaurantData.restaurants)
                
                self.delegate?.didLoadActivities(data: restaurantData)

            }
            
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
    func parseData(restaurantData: Data) -> [String]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: restaurantData)
            var array = [String]()
            var restaurantData = ActivityModel(restaurants:array)
            
            for business in decodedData.businesses {
                
                
                array.append(business.name)
            }
            return array
        }
        catch {
            print(error)
            return nil
        }
        
    }
    
    
    
    
    
    
    
}
