
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
}
