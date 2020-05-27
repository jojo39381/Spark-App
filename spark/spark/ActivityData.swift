
//
//  CategoryData.swift
//  spark
//
//  Created by Joseph Yeh on 5/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

struct ActivityData: Decodable {
    var businesses: [Businesses]
}

struct Result: Decodable {
    var name: String
}
