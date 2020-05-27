//
//  CategoriesManager.swift
//  spark
//
//  Created by Joseph Yeh on 5/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

protocol CategoriesManagerDelegate {
    func didLoadCategories(categoryData:CategoryModel)
    
}

struct CategoriesManager {
    let categoryURL = "https://api.yelp.com/v3/categories"
    
    let API_KEY = "iM7_IkVflupwpcOMUguJXQJK5649MyfnIu7PZnyd6y9T_pFdDUXD4_KO6WofOXm_lIELDMo_tVgi0cY9QFj9gDb7L8j1p95nC1qi1vBH3GUKE586c9bMtqlRVynIXnYx"
    
    var delegate: CategoriesManagerDelegate?
    
    func fetchCategories() {
        let urlString = "\(categoryURL)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            request.addValue("Bearer \(API_KEY)", forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request, completionHandler: handle(data:response:error:))
            
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
            if let categoryData = self.parseJSON(categoryData: safeData) {
                self.delegate?.didLoadCategories(categoryData:categoryData)
                print("lol")
            }
            
        }
    }
    
    func parseJSON(categoryData: Data) -> CategoryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryData.self, from: categoryData)
            var array = [String]()
            var dict = [String:String]()
            var categoryData = CategoryModel(category:dict, activity:dict)
            for category in decodedData.categories {
                let alias = category.parent_aliases
                if alias.contains("restaurants") {
                    let data = category.title
                    categoryData.category.updateValue(category.alias, forKey: data)
                    
                    
                }
                else if ["active", "arts", "resorts", "skiresorts", "tours", "nightlife"].contains(where: alias.contains){
                    let data = category.title
                    categoryData.activity.updateValue(category.alias, forKey: data)
                }
            }
            return categoryData
        }
        catch {
            print(error)
            return nil
        }
        
    }
    
    
    
    
    
}
