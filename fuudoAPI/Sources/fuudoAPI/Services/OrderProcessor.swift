//
//  OrderProcessor.swift
//

import Foundation

public protocol OrderProcessor {
    func placeOrder(_ products: [Product], for offering: Schedule.Offering, user: User) async -> Order?
    func getOrder(offering: Schedule.Offering) async -> Order?
}

class FuudoOrderProcessor: OrderProcessor {    
    // These would likely be stored in some offsite repository - just a quick and dirty implementation.
    private var orders: [Schedule.Offering: Order] = [:]
    
    // Note: Marked async in the contract to allow for some sort of API interaction
    func getOrder(offering: Schedule.Offering) async -> Order? {
        return orders[offering]
    }
        
    // Note: Marked async in the contract to allow for some sort of API interaction
    func placeOrder(_ products: [Product], for offering: Schedule.Offering, user: User) async -> Order? {
        let order = Order(user: user, relatedOffering: offering, products: products)
        orders[offering] = order
        return order
    }
}
