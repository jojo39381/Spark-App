//
//  RestaurantsManager.swift
//  spark
//
//  Created by Joseph Yeh on 5/23/20.
//  Modified by Tinna Liu, Peter Li on 5/1/21.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

protocol ActivityManagerDelegate { // protocol in Swift = interface in Java
    func didLoadActivities(data: ActivityModel)
}

struct ActivityManager {
    let activityUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?parameters"
    let API_KEY = "AIzaSyCyOREZ-tMNFbjcpMcye-58009jQlDh1aA"
    let activityUrl2 = "https://api.yelp.com/v3/businesses/search"
    let API_KEY2 = "iM7_IkVflupwpcOMUguJXQJK5649MyfnIu7PZnyd6y9T_pFdDUXD4_KO6WofOXm_lIELDMo_tVgi0cY9QFj9gDb7L8j1p95nC1qi1vBH3GUKE586c9bMtqlRVynIXnYx"
    
    
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
            print("components ? .url")
            print(components?.url)
            var count = 0
            var result = [Place]()
            
            print("categories")
            print(categories)
            for (key, value) in categories {
                components?.queryItems?.append(URLQueryItem(name: "term", value: key))
                var request = URLRequest(url: (components?.url)!)
                request.addValue("Bearer \(API_KEY2)", forHTTPHeaderField: "Authorization")
                let task = session.dataTask(with: request) { (data, response, error) in
                    
                    if let safeData = data {
                        if let parsed = self.parseData(restaurantData: safeData) {
                            let dataString = String(data: safeData, encoding: .utf8)
//                            print(dataString)
//                            print(parsed)
                            // dataString: unparsed version
                            // parsed: parsed version
                            result += parsed
                        }
                    }
                    do {
                        count += 1
                        if count == self.categories.count {
                            self.handleCompletion(data: result, response: response, error: error)
                            // pass in result!
                        }
                    }
                }
                
                print(components?.url)
                let count = components?.queryItems?.count
                components?.queryItems?.remove(at: count! - 1)
                
                task.resume()
            }
//            print("result")
//            print(result)
        }
        
        
    }
    
    func handleCompletion(data: [Place]?, response: URLResponse?, error: Error?) {
        // data = result (a list of Places)
        if error != nil {
            print(error!)
            return
        }
        let model = ActivityModel(activities: data!)
        self.delegate?.didLoadActivities(data: model)
    }
    
    func parseData(restaurantData: Data) -> [Place]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: restaurantData)
            var array = [Place]()
            for business in decodedData.businesses {
                var alias = [String]()
                for category in business.categories {
                    alias.append(category.title)
                }
                var result = Place()
                result.categories = alias
                result.ratings = business.rating
                result.numReviews = business.review_count
                result.coordinates = business.coordinates
                result.image_url = business.image_url
                result.address = business.location.display_address
                result.name = business.name
                array.append(result)
            }
            var activityData = ActivityModel(activities: array)
            return activityData.activities
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
