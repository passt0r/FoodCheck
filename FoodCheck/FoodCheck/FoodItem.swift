//
//  FoodItem.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 20.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: Base class for all other food types
class FoodType: Object {
    //property type need for implement filtration and base logo for food of  this type.
    //if other icon exist, than this logo name must be choosed in logoType property
    dynamic var name = ""
    dynamic var type: String = "choose_button"
    dynamic var logotipe: String = "choose_button"
    
    //debug methods, type and logo are readed from data base
    func chooseType(ofType logo: LogoType) {
        type = logo.rawValue
        logotipe = logo.rawValue
    }
    
    func chooseLogo(ofType logo: LogoType) {
        logotipe = logo.rawValue
    }
}

//MARK: - This class objects consist time interval of shelf time of food
class FoodItem: FoodType {
    // shelf life representing by time duration in seconds
    //MARK: attention: slelfLife in your fridge is different, depends on date of bying
    dynamic var shelfLife: Double = 1
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}

//MARK: - Stored item in fridge, this class objects consists end date for consuming the food
class FoodItemInFridge: FoodType {
    
    dynamic var endDate: NSDate = NSDate(timeIntervalSince1970: 0)
    
}

//MARK: - enum consist string that represent class of food, need for implement correct icon and filtrarion queries
enum LogoType: String {
    case meet = "beef"
    case fish = "fish"
    case milk = "milk"
    case bread = "bread"
    case vegitables = "vegitables"
    case fruit = "fruit"
    case sweets = "sweets"
    case сanned_goods = "сanned_goods"
    
    case test = "choose_button"
    
    case cucumber = "cucumber"
    case apple = "apple"
    case baguette = "baguette"
    case banana = "banana"
    case bread_2 = "bread_2"
    case broccoli = "broccoli"
    case butter = "butter"
    case cabbage = "cabbage"
    case carrot = "carrot"
    case cheese = "cheese"
    case eggs = "eggs"
    case grapes = "grapes"
    case ham = "ham"
    case ice_cream = "ice_cream"
    case onion = "onion"
    case orange = "orange"
    case pear = "pear"
    case piece_of_cake = "piece_of_cake"
    case potatoes = "potatoes"
    case roast_chicken = "roast_chicken"
    case salami = "salami"
    case salmon = "salmon"
    case strawberry = "strawberry"
    case sushi = "sushi"
    case tomatoes = "tomatoes"
    case tuna = "tuna"
    case yogurt = "yogurt"
    
}





