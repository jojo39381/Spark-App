
//
//  CategoryData.swift
//  spark
//
//  Created by Joseph Yeh on 5/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

// ActivityData is the raw data, it can be parsed to Place struct in ActivityModel
// and stored in activities (a list of Places)
struct ActivityData: Decodable { // raw data
    var businesses: [Business]
}

struct Business: Decodable {
    var name: String
    var categories: [Lol]
    var rating : Float
    var review_count: Float
    var coordinates: Coordinates
    var image_url: String
    var location: Address
    var url: URL
    var price: String
}


struct Lol: Decodable {
    var title: String
}

struct Address: Decodable {
    var display_address: [String]
}


struct Coordinates: Decodable {
    var latitude: Float
    var longitude: Float
    
    init() {
        latitude = 0.0
        longitude = 0.0
    
    }
}


