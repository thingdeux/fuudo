//
//  ScheduleService.swift
//

import Foundation
import OrderedCollections

public protocol ScheduleService {
    func generateFullSchedule(startingFrom: Date, additionalWeeks: Int) async -> [Schedule.Week]
    func getActiveOfferings(after: Date) async -> [Schedule.Offering]
    func getSectionedActiveOfferings(after: Date) async -> OrderedDictionary<String, [Schedule.Offering]>
    func setup() async
}

@available(iOS 13.0, *)
class FuudoScheduler: ScheduleService {
    private(set) var currentSchedule: Schedule.Week?
    private(set) var fullSchedule: [Schedule.Week] = []
    fileprivate let calendar = Calendar.current
    
    private enum Constants {
        static let threeDaysOfHours: Int = 24 * 7
    }
        
    // Note:
    // I'd like to use Async/Await so I'm going to restrict this Package to iOS 13+
    // Certainly not necessary to do so - but it's going to make my life just a bit easier.
    @available(iOS 13.0, *)
    init() {
        Task.init {
            await setup()
        }
    }
    
    // MARK: Public Methods
    public final func generateFullSchedule(startingFrom date: Date = Date(), additionalWeeks: Int = 0) async -> [Schedule.Week] {
        var weeksLeftToGenerate = 2 + additionalWeeks
        var lastWeekGenerated: [Date] = []
        var finalSchedule: [Schedule.Week?] = []
                
        while weeksLeftToGenerate > 0 {
            // If we enter the loop from anything after Week 1
            if !lastWeekGenerated.isEmpty, let previousWeeksFriday = lastWeekGenerated.last,
                // Generate the following week of M-F dates
                let mondayOfTheFollowingWeek = calendar.date(byAdding: .hour, value: Constants.threeDaysOfHours, to: previousWeeksFriday) {
                lastWeekGenerated = await buildNearestWeekdayCollection(from: mondayOfTheFollowingWeek)
            } else {
                // We're at Week #1 - no need to push the clock forward, just generate a week please.
                lastWeekGenerated = await buildNearestWeekdayCollection(from: date)
            }
            
            // There are only 2 provider lists - we start at index 0 (ie: That's week 1) swap between week 1 provider list
            // And week 2 provider list everytime we loop back around.
            let providerListToInject = weeksLeftToGenerate % 2 == 0 ? ProviderConstants.weekOne : ProviderConstants.weekTwo
            finalSchedule.append(buildWeeklyScheduleMapping(using: providerListToInject, for: lastWeekGenerated))
            weeksLeftToGenerate -= 1
        }
        
        return finalSchedule.compactMap({ $0 })                
    }
    
    private func generateOneWeek(startDate: Date?, filledWith providers: [Provider]) async -> Schedule.Week? {
        guard
            let startDate = startDate
        else {
            return nil
        }
        let week =  await buildNearestWeekdayCollection(from: startDate)
        return buildWeeklyScheduleMapping(using: providers, for: week)
    }
    
    public final func getActiveOfferings(after: Date) async -> [Schedule.Offering] {
        // Helper method to flatten the full set of schedule results into an array of offerings after provided date.
        return fullSchedule.map { weeklySchedule in
            weeklySchedule.offerings.compactMap { offering in
                offering.date >= after ? offering : nil
            }
        }.flatMap { $0 }
    }
    
    public final func getSectionedActiveOfferings(after: Date) async -> OrderedDictionary<String, [Schedule.Offering]> {
        var sectionedOfferings: OrderedDictionary<String, [Schedule.Offering]> = [:]
        for week in fullSchedule {
            sectionedOfferings[week.weekId] = week.offerings
        }
        return sectionedOfferings
    }
}


// MARK: Implementation + Internal Methods
extension FuudoScheduler {
    final func setup() async {
        // TODO: Rotating almost implies the schedule should repeat ad infinitum ... not just generate 2 weeks
        //
        // I can generate indefinitely here for all of the current year if necessary. Maybe with some modulus operation
        // to jump back and forth between week 1 and 2. Contract remains the same.
        // Maybe allow for a parameter that specifies how many weeks forward to continue generation.
        fullSchedule = await generateFullSchedule(startingFrom: Date(), additionalWeeks: 10)
        currentSchedule = fullSchedule.first
    }
    
    final func getCurrentDayOfTheWeek(from date: Date = Date()) -> Weekday {
        // Note: Going to need Timezone
        var componentsRequired = Set<Foundation.Calendar.Component>()
        componentsRequired.insert(.weekday)
        let dateComponents = calendar.dateComponents(componentsRequired, from: date)
        if let weekDayAsInt = dateComponents.weekday, let weekday = Weekday(rawValue: weekDayAsInt) {
            return weekday
        }
        
        return .unknown
    }
    
    final func findNearestSunday(from date: Date, using: Calendar) -> Date? {
        // First: Find the right Sunday (whether we go forwards or backwards depends on whether or not the date is a Weekend date.
        // Note: Only finding Sunday because the Foundation Calendar likes to start the week at Sunday - best to play nice.
        let findASaturdayComponentRule = DateComponents(calendar: calendar, weekday: Weekday.sunday.rawValue)
        let nextSunday = calendar.nextDate(after: date, matching: findASaturdayComponentRule, matchingPolicy: .strict)
        
        if let nextSunday = nextSunday {
            // We're currently in the weekend - return Sunday
            if calendar.isDateInWeekend(date) {
                return nextSunday
            } else {
                // TODO: Revisit
                // I don't like this ... specifically the calculation ... works though 😬
                let lastSunday = calendar.date(byAdding: .hour, value: -24*7, to: nextSunday, wrappingComponents: false)
                return lastSunday
            }
        }
        return nil
    }
    
    // Generates a week of dates starting on Monday from a given date.
    // Note: If the date given is a Saturday or Sunday the nearest week is the week after the weekend.
    final func buildNearestWeekdayCollection(from date: Date) async  -> [Date] {
        // First: Find the right Sunday
        guard let startingSunday = findNearestSunday(from: date, using: calendar) else { return [] }
        
        // Second: Insert the Monday then walk to Friday inserting at each step.
        return await withCheckedContinuation { promise in
            let calendar = Calendar.current
            // Not optimal - would rather have used Apples' enumerateDays from Calendar but ... was getting bogged down
            // So moved on with a less optimal solution.
            DispatchQueue.global().async {
                var weekDays: [Date] = []
                var nextDay: Date? = calendar.date(byAdding: .day, value: 1, to: startingSunday)
                
                while nextDay?.isWeekend != true {
                    if let dateToAdd = nextDay {
                        weekDays.append(dateToAdd)
                        nextDay = calendar.date(byAdding: .day, value: 1, to: dateToAdd)
                    }
                }
                promise.resume(returning: weekDays)
            }
        }
    }
}
