//
//  DaysCountDownAppTests.swift
//  DaysCountDownAppTests
//
//  Created by Vinayaka on 15/03/24.
//

import XCTest

@testable import DaysCountDownApp

final class DaysCountDownAppTests: XCTestCase {

    var viewController: ViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        super.tearDown()
    }

    func testExample() throws {
        XCTAssertNotNil(viewController.timerData)
        XCTAssertEqual(viewController.timerData?.days, 10)
        XCTAssertEqual(viewController.timerData?.hours, 8)
        XCTAssertEqual(viewController.timerData?.minutes, 33)
        XCTAssertEqual(viewController.timerData?.seconds, 23)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUpdateUI() {
        viewController.timerData = CountdownTimer(days: 7, hours: 12, minutes: 45, seconds: 30)
        guard let timerData = viewController.timerData else { return }
        viewController.updateUI(with: timerData)
        
        XCTAssertEqual(viewController.daysView.countDownLabel.text, "07")
        XCTAssertEqual(viewController.hoursView.countDownLabel.text, "12")
        XCTAssertEqual(viewController.minutesView.countDownLabel.text, "45")
        XCTAssertEqual(viewController.secondsView.countDownLabel.text, "30")
    }
    
    func testCalculateRemainingTime() {
        let initialTime = CountdownTimer(days: 1, hours: 10, minutes: 30, seconds: 15)
        let elapsedTime: TimeInterval = 3600 // 1 hour
        
        let remainingTime = viewController.calculateRemainingTime(initialTime: initialTime, elapsedTime: elapsedTime)
        
        XCTAssertEqual(remainingTime.days, 1)
        XCTAssertEqual(remainingTime.hours, 9)
        XCTAssertEqual(remainingTime.minutes, 30)
        XCTAssertEqual(remainingTime.seconds, 15)
    }

}
