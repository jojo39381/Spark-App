
//
//  CategoryData.swift
//  spark
//
//  Created by Joseph Yeh on 5/22/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

struct CategoryData: Decodable {
    let categories: [Categories]
}

struct Categories: Decodable {
    let title: String
    let parent_aliases:[String]
}
