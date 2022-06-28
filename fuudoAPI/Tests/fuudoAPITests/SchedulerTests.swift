//
//  SchedulerTests.swift
//  

import XCTest
@testable import fuudoAPI

final class SchedulerTests: XCTestCase {
    // Hmm, wonder what this would product running on some CI Server?
    // *Should* be fine if running on an iOS Sim - would probably research before
    // commiting to prod.
    let calendar = Calendar.current
    
    func testWeekDayIdentifiedCorrectlyAsTuesday() {
        let scheduler = FuudoScheduler()
        let tuesdayMay31st2022 = Date(timeIntervalSince1970: 1653980400)
        let dayOfTheWeek = scheduler.getCurrentDayOfTheWeek(from: tuesdayMay31st2022)
        XCTAssertEqual(dayOfTheWeek, .tuesday)
    }

    func testWeekDayIdentifiedCorrectlyAsFriday() {
        let scheduler = FuudoScheduler()
        let fridayJune3rd2022 = Date(timeIntervalSince1970: 1654239600)
        let dayOfTheWeek = scheduler.getCurrentDayOfTheWeek(from: fridayJune3rd2022)
        XCTAssertEqual(dayOfTheWeek, .friday)
    }

    func testWeekDayIdentifiedCorrectlyAsSaturday() {
        let scheduler = FuudoScheduler()
        let saturdayJune4th2022 = Date(timeIntervalSince1970: 1654326000)
        let dayOfTheWeek = scheduler.getCurrentDayOfTheWeek(from: saturdayJune4th2022)
        XCTAssertEqual(dayOfTheWeek, .saturday)
    }
    
    func testNearestSundayReturnsBeginningOfTheWeek() {
        /*
         The nearest sunday method should return the closest Sunday for a given day of the week.
         Any input date Saturday or Sunday should return the Sunday from the start of the upcoming week.
         
         - else -
         
         Should return next Sunday.
       */
        let scheduler = FuudoScheduler()
        let saturdayJune4th = Date(timeIntervalSince1970: 1654326000)
        let nearestSunday = scheduler.findNearestSunday(from: saturdayJune4th, using: calendar)
        
        if let nearestSunday = nearestSunday {
            let dateComponents = calendar.dateComponents([.weekday, .day], from: nearestSunday)
            XCTAssertEqual(dateComponents.weekday, FuudoScheduler.Weekday.sunday.rawValue)
            // The Sunday before Tuesday, May 31st, 2022 is the 29th
            XCTAssertEqual(dateComponents.day, 5)
        } else {
            XCTFail("Sunday not generated at all!!")
        }
    }
    
    func testNearestSundayReturnsBeginningOfNextWeekWhenUsingWeekendAsInput() {
        /*
         The nearest sunday method should return the closest Sunday for a given day of the week.
         Any input date M-F should return the Sunday from the start of the week.
         
         - else -
         
         Should return next Sunday.
      */
        let scheduler = FuudoScheduler()
        let tuesdayMay31st2022 = Date(timeIntervalSince1970: 1653980400)
        let nearestSunday = scheduler.findNearestSunday(from: tuesdayMay31st2022, using: calendar)
        
        if let nearestSunday = nearestSunday {
            let dateComponents = calendar.dateComponents([.weekday, .day], from: nearestSunday)
            XCTAssertEqual(dateComponents.weekday, FuudoScheduler.Weekday.sunday.rawValue)
            // The Sunday before Tuesday, May 31st, 2022 is the 29th
            XCTAssertEqual(dateComponents.day, 29)
        } else {
            XCTFail("Sunday not generated at all!!")
        }
    }
}

// MARK: Full Week Generation Tests
extension SchedulerTests {
    func testWeekGenerationFromDate() async {
        /*
         This test makes sure, given a day of the week, a collection of 5 dates will be generated.
         One for each weekday - starting Monday and ending Friday.
       */
        let scheduler = FuudoScheduler()
        let tuesdayMay31st2022 = Date(timeIntervalSince1970: 1653980400)
        let collection = await scheduler.buildNearestWeekdayCollection(from: tuesdayMay31st2022)
        
        XCTAssertEqual(collection.count, 5)
        
        // Make sure the 3rd element is Wednesday
        let wednesday = collection[2]
        let wednesdayComponents = calendar.dateComponents([.weekday], from: wednesday)
        XCTAssertEqual(wednesdayComponents.weekday, FuudoScheduler.Weekday.wednesday.rawValue)
        
        // Make sure the 5th element is Friday
        let friday = collection[4]
        let fridayComponents = calendar.dateComponents([.weekday], from: friday)
        XCTAssertEqual(fridayComponents.weekday, FuudoScheduler.Weekday.friday.rawValue)
    }
    
    func testFullScheduleGeneratesSuccesfully() async {
        /*
         This test makes sure that a complete 2 week schedule is generated.
       */
        let scheduler = FuudoScheduler()
        let tuesdayMay31st2022 = Date(timeIntervalSince1970: 1653980400)
        let collection = await scheduler.generateFullSchedule(startingFrom: tuesdayMay31st2022)
        
        // 2 Weekly Schedules
        XCTAssertEqual(collection.count, 2)
        
        // 5 Offerings generated in the first week (M-F)
        XCTAssertTrue(collection.first?.offerings.count == 5)
        
        // 5 Offerings generated in the second week (M-F)
        XCTAssertTrue(collection.last?.offerings.count == 5)
        
        // One entry for each day
        if let weekOne = collection.first {
            let mondayThroughFriday: [FuudoScheduler.Weekday] = weekOne.offerings.compactMap({ offering in
                let dayOfTheWeek = calendar.component(.weekday, from: offering.date)
                return FuudoScheduler.Weekday(rawValue: dayOfTheWeek)
            })
            
            // Convert to set for cheaper lookups. Maybe overkill
            let daysGeneratedInWeekOne = Set<FuudoScheduler.Weekday>(mondayThroughFriday)
            
            XCTAssertTrue(daysGeneratedInWeekOne.contains(.monday))
            XCTAssertTrue(daysGeneratedInWeekOne.contains(.tuesday))
            XCTAssertTrue(daysGeneratedInWeekOne.contains(.wednesday))
            XCTAssertTrue(daysGeneratedInWeekOne.contains(.thursday))
            XCTAssertTrue(daysGeneratedInWeekOne.contains(.friday))
        } else {
            XCTFail("Unable to use generated week one collection")
        }
    }
    
    func testWeekOneInProperOrder() async {
        /*
         Make sure the generated schedule offerings match the order provided in the spec for week 1.
       */
        let scheduler = FuudoScheduler()
        let tuesdayMay31st2022 = Date(timeIntervalSince1970: 1653980400)
        let collection = await scheduler.generateFullSchedule(startingFrom: tuesdayMay31st2022)
        
        if let weekOne = collection.first {
            let mondayThroughFriday: [Provider] = weekOne.offerings.compactMap({ offering in
                offering.provider
            })
            
            XCTAssertEqual(mondayThroughFriday, ProviderConstants.weekOne)
        } else {
            XCTFail("Unable to use generated week one collection")
        }
    }
    
    func testWeekTwoInProperOrder() async {
        /*
         Make sure the generated schedule offerings match the order provided in the spec for week 2.
       */
        let scheduler = FuudoScheduler()
        let tuesdayMay31st2022 = Date(timeIntervalSince1970: 1653980400)
        let collection = await scheduler.generateFullSchedule(startingFrom: tuesdayMay31st2022)
        
        if let weekOne = collection.last {
            let mondayThroughFriday: [Provider] = weekOne.offerings.compactMap({ offering in
                offering.provider
            })
            
            XCTAssertEqual(mondayThroughFriday, ProviderConstants.weekTwo)
        } else {
            XCTFail("Unable to use generated week one collection")
        }
    }
}
