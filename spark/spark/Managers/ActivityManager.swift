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
    
    
    
    
    var delegate: ActivityManagerDelegate?
    var categories: [String:String]
    var budget: [String]
    func fetchActivities() {
        let urlString = activityUrl2
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string:urlString) {



            var latitude = "\(userLocation.coordinate.latitude)"
            var longitude =  "\(userLocation.coordinate.longitude)"
            var components = URLComponents(string: urlString)

            components?.queryItems = [


                URLQueryItem(name: "radius", value: "\(radius)"),
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitude),
                URLQueryItem(name: "sort_by", value: "best_match"),
                URLQueryItem(name: "limit", value: "10"),
                URLQueryItem(name: "price", value: budget[0])




            ]








            var request = URLRequest(url: (components?.url)!)
            let session = URLSession(configuration: .default)
            print(components?.url)
            var count = 0
            var result = [String:[Any]]()
            for (key, value) in categories {

                components?.queryItems?.append(URLQueryItem(name: "term", value: key))
                var request = URLRequest(url: (components?.url)!)
                request.addValue("Bearer \(API_KEY2)", forHTTPHeaderField: "Authorization")
                let task = session.dataTask(with: request) { (data, response, error) in

                    if let safeData = data {

                        if let parsed = self.parseData(restaurantData: safeData) {
                            let dataString = String(data: safeData, encoding: .utf8)
                            print(dataString)
                            result.merge(dict:parsed)
                        }
                    }

                    do {
                        count += 1
                        if count == self.categories.count {
                            self.handleCompletion(data: result, response: response, error: error)
                        }
                    }

                }

                print(components?.url)
                let count = components?.queryItems?.count
                components?.queryItems?.remove(at: count! - 1)
                
                task.resume()
            }

        }

        
    }

    func handleCompletion(data: [String: [Any]]?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        let model = ActivityModel(restaurants: data!)
        self.delegate?.didLoadActivities(data: model)


    }
    
    func parseData(restaurantData: Data) -> [String: [Any]]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: restaurantData)
            var array = [String:[[String]]]()
            var restaurantData = ActivityModel(restaurants:array)
            
            for business in decodedData.businesses {
                
                print(business.name)
                print(business.categories)
                var result = [Any]()
                var alias = [String]()
                for category in business.categories {
                    alias.append(category.title)
                }
                result.append(alias)
                result.append(business.rating)
                result.append(business.review_count)
                let coordinates = [business.coordinates.latitude, business.coordinates.longitude]
                result.append(coordinates)
                result.append(business.image_url)
                result.append(business.location.display_address)
                result.append(business.url)
                restaurantData.restaurants.updateValue(result, forKey: business.name)
            }
            return restaurantData.restaurants
                
        }
        catch {
            print(error)
            return nil
        }
        
        
    }
    
    
}

    
    
    
    
    
    
    



extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
