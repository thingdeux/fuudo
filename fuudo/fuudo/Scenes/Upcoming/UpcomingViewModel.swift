//
//  UpcomingViewModel.swift
//

import Foundation
import Combine
import SwiftUI
import fuudoAPI
import OrderedCollections

class UpcomingViewModel: ObservableObject {
    typealias TitledWeekSchedule = (sectionTitle: String, offerings: [Schedule.Offering])
    private typealias OrderedWeekCollection = OrderedDictionary<String, [Schedule.Offering]>
    
    @Published private(set) var upcomingOfferings: [TitledWeekSchedule] = []
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
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()),
            let earliestPointTomorrow = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: tomorrow)
        else {
            // We're in huge trouble!
            // TODO: Set some kind of generic error context here for us being in huge trouble.
            self.setLoading(to: false)
            return
        }
        let upcomingWeeks = await scheduleService.getSectionedActiveOfferings(after: earliestPointTomorrow)
        let chunkedSections = chunkWeeksIntoTitledSections(weeks: upcomingWeeks, overridingTitlesForEntries: [
            0: "This Week",
            1: "Next Week"
        ])
        // Wait for a couple of seconds - we'll pretend the API is communicating with a remote server 🤫.
        let threeSecondsInNanoSeconds: UInt64 = 2_000_000_000 / 3
        try? await Task.sleep(nanoseconds: threeSecondsInNanoSeconds)
        
        DispatchQueue.main.async {
            withAnimation {
                self.setLoading(to: false)
                self.upcomingOfferings = chunkedSections
            }
        }
    }
    
    private func chunkWeeksIntoTitledSections(weeks: OrderedWeekCollection, overridingTitlesForEntries: [Int: String]) -> [TitledWeekSchedule] {
        let dataSetWithIndexes = Array(zip(weeks.elements.indices, weeks.elements))
        var sectionedWeeks: [TitledWeekSchedule] = []
        
        for (index, offerings) in dataSetWithIndexes {
            if let titleToInject = overridingTitlesForEntries[index] {
                sectionedWeeks.append((titleToInject, offerings.value))
            } else {
                sectionedWeeks.append(("Week \(index + 1)", offerings.value))
            }
            
        }
        return sectionedWeeks
    }
        
    private func setLoading(to value: Bool) {
        // Make sure loading always gets set on the main thread
        DispatchQueue.main.async {
            withAnimation {
                self.isLoading = value
            }
        }
    }
}
