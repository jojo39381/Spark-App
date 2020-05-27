//
//  DateModel.swift
//  spark
//
//  Created by Joseph Yeh on 5/25/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import Foundation

struct DateModel {
    var dateCategories : [String] = ["Chill" , "Romantic" , "Casual" , "Adventurous" , "Tourist", "Random"]
    var foodCategory = [String]()
    var activityCategory = [String]()
    
    mutating func getDateParameters(style: String) {
        switch style {
        case "Chill":
            self.foodCategory = []
            self.activityCategory = []
            return
        case "Romantic":
            self.foodCategory = []
            self.activityCategory = []
            return
        case "Casual":
            self.foodCategory = []
            self.activityCategory = []
            return
        case "Adventurous":
            self.foodCategory = []
            self.activityCategory = []
            return
        case "Tourist":
            self.foodCategory = []
            self.activityCategory = []
            
        default:
            self.foodCategory = []
            self.activityCategory = []
            return
        }
        
    }
}
