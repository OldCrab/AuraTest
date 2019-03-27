//
//  IncrementorTests.swift
//  AuraTestTests
//
//  Created by Andrew Vasiliev on 27/03/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import XCTest
@testable import AuraTest

class IncrementorTests: XCTestCase {
    var incrementor = Incrementor()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        incrementor = Incrementor()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConcurrent() {
        let dispatchGroup = DispatchGroup()

        let expectation = self.expectation(description: "Handler called")

        for _ in 0..<10000 {
            dispatchGroup.enter()

            DispatchQueue.global().async {
                self.incrementor.incrementNumber()
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            expectation.fulfill()
            XCTAssertEqual(self.incrementor.getNumber(), 10000)
        }

        self.waitForExpectations(timeout: 2, handler: nil)
    }

    func testLimitLessThanZero() {
        incrementor.setMaximumValue(-1)

        for _ in 0..<10 {
            incrementor.incrementNumber()
        }

        XCTAssertEqual(self.incrementor.getNumber(), 10)
    }

    func testLimitZero() {
        incrementor.setMaximumValue(0)

        for _ in 0..<10 {
            incrementor.incrementNumber()
        }

        XCTAssertEqual(self.incrementor.getNumber(), 0)
    }

    func testLimitChanging() {
        incrementor.setMaximumValue(10)

        for _ in 0..<11 {
            incrementor.incrementNumber()
        }

        XCTAssertEqual(self.incrementor.getNumber(), 0)
    }
}
