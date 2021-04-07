//
//  RestaurantModel.swift
//  spark
//
//  Created by Joseph Yeh on 5/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

struct ActivityModel {
    
    
    // [businessName : [[categories that it belongs to], ratings, numReviews, [latitude, longitude], image_url, address]
    var activities: [Place]
}



struct Place {
    init() {
        name = ""
        categories = [String]()
        ratings = 0.0
        numReviews = 0
        coordinates = Coordinates()
        image_url = ""
        address = [String]()
        }
    var name: String
    var categories: [String]
    var ratings: Float
    var numReviews: Float
    var coordinates: Coordinates
    var image_url: String
    var address: [String]
    
}





























