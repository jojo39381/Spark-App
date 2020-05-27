//
//  RestaurantsManager.swift
//  spark
//
//  Created by Joseph Yeh on 5/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

protocol RestaurantsManagerDelegate {
    func didLoadRestaurants(data: RestaurantModel)
}
struct RestaurantsManager {
    let restaurantsURL = "https://api.yelp.com/v3/businesses/search"
    let API_KEY = "iM7_IkVflupwpcOMUguJXQJK5649MyfnIu7PZnyd6y9T_pFdDUXD4_KO6WofOXm_lIELDMo_tVgi0cY9QFj9gDb7L8j1p95nC1qi1vBH3GUKE586c9bMtqlRVynIXnYx"
    
    
    
    
    var delegate: RestaurantsManagerDelegate?
    var categories: [String:String]
    func fetchRestaurants() {
        let urlString = restaurantsURL
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string:urlString) {
            
            
            var components = URLComponents(string: urlString)
            
            var latitude = "37.866309"
            var longitude =  "-122.254605"
            
            components?.queryItems = [
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitude),
                URLQueryItem(name: "price", value: "1, 2")
            
               
            ]
            
            for (key, value) in categories {
                print("bbbbbbbbbbbbbb")
                print(value)
                components?.queryItems?.append(URLQueryItem(name: "categories", value: value))
                
            }
            
            
            var request = URLRequest(url: (components?.url)!)
            let session = URLSession(configuration: .default)
            request.addValue("Bearer \(API_KEY)", forHTTPHeaderField: "Authorization")
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
            
            if let restaurantData = self.parseJSON(restaurantData: safeData) {
                print("lol")
                print(restaurantData.restaurants)
                print(restaurantData.restaurants.count)
                self.delegate?.didLoadRestaurants(data: restaurantData)
            }
            
        }
        
    }
    
    func parseJSON(restaurantData: Data) -> RestaurantModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RestaurantsData.self, from: restaurantData)
            var array = [String]()
            var restaurantData = RestaurantModel(restaurants:array)
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
