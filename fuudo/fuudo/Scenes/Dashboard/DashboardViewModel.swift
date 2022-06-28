//
//  DashboardViewModel.swift
//  fuudo

import Foundation
import Combine
import SwiftUI
import fuudoAPI

class DashboardViewModel: ObservableObject {
    @Published private(set) var todaysOffering: BadgeDisplayable?
    @Published private(set) var tomorrowsOffering: BadgeDisplayable?
    @Published private(set) var orderDetails: Order?
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var isWeekend: Bool = false
    
    private var scheduleService: ScheduleService
    private var orderProcessor: OrderProcessor
    
    init(using scheduleService: ScheduleService, orderProcessor: OrderProcessor) {
        self.scheduleService = scheduleService
        self.orderProcessor = orderProcessor
    }
    
    func onAppear() async {
        guard
            let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
            
            // TODO: Could be neat to allow the user to move days to debug.
            // Working on the weekend - needed to move the day
//             let today = Calendar.current.date(byAdding: .day, value: 3, to: Date())
        else {
            // We're in huge trouble!
            // TODO: Set some kind of generic error context here for us being in huge trouble.
            isLoading = false
            return
        }
        
        self.isWeekend = Calendar.current.isDateInWeekend(today)
        let thisWeeksActiveOfferings = await scheduleService.getActiveOfferings(after: today)
        todaysOffering = thisWeeksActiveOfferings.first
        
        if thisWeeksActiveOfferings.count > 1 {
            tomorrowsOffering = thisWeeksActiveOfferings[1]
        }
        
        let order = await getOrPlaceCurrentOrder(for: thisWeeksActiveOfferings.first)
        
        DispatchQueue.main.async {
            withAnimation {
                self.orderDetails = order
                self.isLoading = false
            }
        }
    }
    
    private func getOrPlaceCurrentOrder(for offering: Schedule.Offering?) async -> Order? {
        guard
            let offering = offering
        else {
            print("Error! There's no default offering scheduled for today.")
            return nil
        }
        
        let orderDetails = await orderProcessor.getOrder(offering: offering)
        // No order found - pick the top thing off of the menu for now.
        if orderDetails == nil {
            return await placeDefaultOrder(from: offering)
        }
        return orderDetails
    }
    
    private func placeDefaultOrder(from offering: Schedule.Offering) async -> Order? {
        guard
            let firstAvailableItem = offering.provider.productsOffered.first
        else {
            print("Error! There's no default offering scheduled for today.")
            return nil
        }
        
        return  await orderProcessor.placeOrder([firstAvailableItem], for: offering, user: User.standardUser)
    }
}
