//
//  Order.swift
//  

import Foundation

public struct Order {
    public let user: User
    public let relatedOffering: Schedule.Offering
    public let products: [Product]
}
