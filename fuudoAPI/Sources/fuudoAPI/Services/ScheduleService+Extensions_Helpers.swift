//
//  Schedule+Extensions_Helpers.swift
//  

import Foundation

// MARK: Helpers
extension FuudoScheduler {
    enum Weekday: Int {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
        case unknown = 999
        
        var firstLetter: Character {
            switch self {
            case .sunday: return "☀️"
            case .monday: return "M"
            case .tuesday: return"T"
            case .wednesday: return "W"
            case .thursday: return "T"
            case .friday: return "F"
            case .saturday: return "S"
            case .unknown: return "?"
            }
        }
    }
    
    func buildWeeklyScheduleMapping(using providers: [Provider], for dates: [Date]) -> Schedule.Week? {
        guard providers.count == dates.count else { return nil }
        let offerings = zip(providers, dates).compactMap { (provider, date) in            
            // [Stretch Goal]: Thought it'd be neat to have an expected date of arrival re: availableBy
            Schedule.Offering(provider: provider, date: date)
        }
        return Schedule.Week(offerings)
    }
}

extension Date {    
    var isWeekend: Bool {
        let calendar = Calendar.current
        return calendar.isDateInWeekend(self)
    }
}

