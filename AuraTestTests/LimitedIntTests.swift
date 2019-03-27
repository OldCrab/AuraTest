//
//  LimitedIntTests.swift
//  AuraTestTests
//
//  Created by Andrew Vasiliev on 27/03/2019.
//  Copyright © 2019 deepkotix. All rights reserved.
//

import XCTest
@testable import AuraTest

class LimitedIntTests: XCTestCase {
    var value: LimitedInt = 0

    override func setUp() {
    }

    override func tearDown() {
        value = 0
    }

    func testMaxIntLimit() {
        value.set(limit: .max)

        value += .max

        XCTAssertEqual(value.intValue, .max)

        value += 0

        XCTAssertEqual(value.intValue, .max)

        value += 1

        XCTAssertEqual(value.intValue, 0)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDefaultLimitedInt() {
        XCTAssertEqual(value.intValue, 0)

        value += .max

        XCTAssertEqual(value.intValue, .max)

        value += 1

        XCTAssertEqual(value.intValue, 0)
    }

    func testMultipleAdditions() {
        value += 1
        value += 2
        value += 3
        value += 4
        value += 5

        XCTAssertEqual(value.intValue, 15)
    }

    func testBigLimit() {
        value += 1
        value += 2

        value.set(limit: 2)
        XCTAssertEqual(value.intValue, 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
