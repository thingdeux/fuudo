//
//  Product.swift
//  

import Foundation
import SwiftUI

public struct Product {
    public enum Make: String {
    case food
    case drink
    case dessert
    case snack
    case condiment
    }
    
    public let name: String
    public let type: Make
    // Don't love this - should be some image url for a remote image 😡
    public let promoImage: Image?
    public let ingredients: [String]
    public let dietaryFulfillments: [DietaryNeed]
    // Note: Should only be applied to 'food' items and reject anything that's not food.
    // (ie: Rating Ketchup isn't exactly valuable.)
    var aggregateRatings: Int = 0
    
    public init(name: String, type: Make, promoImage: Image? = nil, ingredients: [String] = [], dietaryFulfillments: [DietaryNeed] = []) {
        self.name = name
        self.type = type
        self.promoImage = promoImage
        self.ingredients = ingredients
        self.dietaryFulfillments = dietaryFulfillments        
    }
}

extension Product: Hashable, Equatable {
  public static func == (lhs: Product, rhs: Product) -> Bool {
      return lhs.name == rhs.name &&
               lhs.type == rhs.type &&
               lhs.ingredients == rhs.ingredients &&
               lhs.dietaryFulfillments == rhs.dietaryFulfillments
  }
    
  public func hash(into hasher: inout Hasher) {
      hasher.combine(name)
      hasher.combine(type)
      hasher.combine(ingredients)
      hasher.combine(dietaryFulfillments)
  }
}

public enum DietaryNeed: String {
    case vegan
    case vegetarian
    case paleo
    case lowSodium = "Low Sodium"
    case glutenFree = "Gluten Free"
    case keto
    case dairyLactoseFree = "Lactose Free"
    case halal
    case shellFishAllergyTolerant = "Shellfish"
}
