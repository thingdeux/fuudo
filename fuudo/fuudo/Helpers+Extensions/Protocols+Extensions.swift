//
//  Protocols+Extensions.swift
//

import Foundation
import SwiftUI
import fuudoAPI

protocol BadgeDisplayable {
    var image: Image? { get }
    var titleText: String { get }
    var bodyText: String? { get }
}

extension Schedule.Offering: BadgeDisplayable {
    var image: Image? {
        // This should be a picture for the first meal for every day of the week on the schedule
        self.provider.productsOffered.first?.promoImage
    }
    
    var titleText: String {
        self.provider.name
    }
    
    var bodyText: String? {
        self.provider.productsOffered.compactMap { product in
            product.name
        }.joined(separator: " | ")
    }
}

extension Product: BadgeDisplayable {
    var image: Image? {
        self.promoImage
    }
    
    var titleText: String {
        self.name
    }
    
    var bodyText: String? {        
        let ingredientsList = self.ingredients.compactMap({ $0 })
        return ingredientsList.joined(separator: " | ")
    }
}

extension Provider: BadgeDisplayable {
    var image: Image? {
        self.promoImage
    }
    
    var titleText: String {
        self.name
    }
    
    var bodyText: String? {
        self.productsOffered.debugDescription
    }
}

extension Order: BadgeDisplayable {
    var image: Image? {
        self.products.first?.promoImage
    }
    
    var titleText: String {
        self.products.first?.name ?? "- -"
    }
    
    var bodyText: String? {
        let ingredientsList = self.products.first?.ingredients.compactMap({ $0 }) ?? []
        return ingredientsList.joined(separator: " | ")
    }
}
