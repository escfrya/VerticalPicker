//
//  VerticalPickerTests.swift
//  VerticalPickerTests
//
//  Created by Igor on 01/07/2017.
//  Copyright © 2017 xuli. All rights reserved.
//

import XCTest
@testable import VerticalPicker

class VerticalPickerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: - top offset by value
    
    func testTopOffsetForZeroValue() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 0, minValue: 0, maxValue: 1, height: 100, reversed: false), 100)
    }
    
    func testTopOffsetForMaxValue() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 1, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
    }
    
    func testTopOffsetForAverageValue() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 0.7, minValue: 0, maxValue: 1, height: 100, reversed: false), 30)
    }
    
    func testTopOffsetForValueLessMin() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: -1, minValue: 0, maxValue: 1, height: 100, reversed: false), 100)
    }
    
    func testTopOffsetForValueGreaterMax() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 2, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
    }
    
    // MARK: - value by top offset
    
    func testValueForZeroTopOffset() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 0, minValue: 0, maxValue: 1, height: 100, reversed: false), 1)
    }
    
    func testValueForMaxTopOffset() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 100, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
    }
    
    func testValueForAverageTopOffset() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 30, minValue: 0, maxValue: 1, height: 100, reversed: false), 0.7)
    }
    
    func testValueForTopOffsetLessMin() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: -50, minValue: 0, maxValue: 1, height: 100, reversed: false), 1)
    }
    
    func testValueForTopOffsetGreaterMax() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 150, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
    }
}
