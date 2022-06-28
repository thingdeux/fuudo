//
//  Schedule.swift
//

import Foundation

public struct Schedule {
    public struct Week {
        // Bit of a cheat - just want to quickly find these weeks for section chunking.
        public let weekId: String
        public let offerings: [Schedule.Offering]
        
        public init(_ offerings: [Schedule.Offering]) {
            self.weekId = UUID().uuidString
            self.offerings = offerings
        }
    }
    
    // TODO: Revisit the name 'Offering' 😭 - don't love it.
    public struct Offering {
        public let provider: Provider
        public let date: Date
        
        public var dayOfTheWeekLetter: Character {
            let weekdayComponents = Calendar.current.dateComponents([.weekday], from: self.date)
            
            guard
                let weekDayInt = weekdayComponents.weekday,
                let weekday = FuudoScheduler.Weekday(rawValue: weekDayInt)
            else {
                return "?"
            }
            return weekday.firstLetter
        }
        
        public init(provider: Provider, date: Date) {
            self.provider = provider
            self.date = date
        }
    }
}

extension Schedule.Offering: Equatable, Hashable {
    public static func == (lhs: Schedule.Offering, rhs: Schedule.Offering) -> Bool {
        return lhs.date == rhs.date &&
                lhs.provider == rhs.provider
    }
}
