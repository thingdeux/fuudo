//
//  Mocks.swift
//  fuudo

import Foundation
import SwiftUI
import fuudoAPI
import OrderedCollections

class Mocks {
    static var scheduleService: ScheduleService = MockScheduleService()
    static var orderProcessesor: OrderProcessor = MockOrderProcessor()
    
    static let mockProvider = Provider(name: "Dales Donuts", productsOffered: [mockProduct], promoImage: nil)
    static let mockProduct = Product(name: "Chicken and waffles", type: .snack, promoImage: Image("waffleImage"),
                                            ingredients: ["Chicken", "Waffles"], dietaryFulfillments: [.shellFishAllergyTolerant])
}

private struct MockScheduleService: ScheduleService {
    func getSectionedActiveOfferings(after: Date) async -> OrderedDictionary<String, [Schedule.Offering]> {
        [:]
    }
    
    func generateFullSchedule(startingFrom: Date, additionalWeeks: Int) async -> [Schedule.Week] {
        return [mockWeek, mockWeek]
    }
    
    let mockWeek: Schedule.Week = Schedule.Week([
        Schedule.Offering(provider: Mocks.mockProvider, date: Date())
    ])
    
    func getActiveOfferings(after: Date) -> [Schedule.Offering] {
        return [
            Schedule.Offering(provider: Mocks.mockProvider, date: Date())
        ]
    }
    
    func setup() async {
    }
}

private struct MockOrderProcessor: OrderProcessor {
    func placeOrder(_ products: [Product], for offering: Schedule.Offering, user: User) async -> Order? {
        return nil
    }
    
    func getOrder(offering: Schedule.Offering) async -> Order? {
        return nil
    }
}
