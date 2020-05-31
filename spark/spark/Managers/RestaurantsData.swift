
//
//  CategoryData.swift
//  spark
//
//  Created by Joseph Yeh on 5/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

struct RestaurantsData: Decodable {
    var businesses: [Businesses]
}

struct Businesses: Decodable {
    var name: String
    var categories: [Lmao]
    var rating : Float
    var review_count: Float
    var coordinates: Coordinates
    
        
}

struct Lmao: Decodable {
    var alias: String
}

struct Coordinates: Decodable {
    var latitude: Float
    var longitude: Float
}