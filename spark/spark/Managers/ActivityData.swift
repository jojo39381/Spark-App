
//
//  CategoryData.swift
//  spark
//
//  Created by Joseph Yeh on 5/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

struct ActivityData: Decodable {
    var businesses: [Business]
}

struct Business: Decodable {
     var name: String
       var categories: [Lmao]
       var rating : Float
       var review_count: Float
       var coordinates: Coordinates
}


struct Lol: Decodable {
    var alias: String
}

