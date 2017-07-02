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
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 0, minValue: 0, maxValue: 1, height: 100, reversed: true), 0)
    }
    
    func testTopOffsetForMaxValue() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 1, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 1, minValue: 0, maxValue: 1, height: 100, reversed: true), 100)
    }
    
    func testTopOffsetForAverageValue() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 0.7, minValue: 0, maxValue: 1, height: 100, reversed: false), 30)
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 0.7, minValue: 0, maxValue: 1, height: 100, reversed: true), 70)
    }
    
    func testTopOffsetForValueLessMin() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: -1, minValue: 0, maxValue: 1, height: 100, reversed: false), 100)
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: -1, minValue: 0, maxValue: 1, height: 100, reversed: true), 0)
    }
    
    func testTopOffsetForValueGreaterMax() {
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 2, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
        XCTAssertEqual(OffsetCalculator.topOffsetBy(value: 2, minValue: 0, maxValue: 1, height: 100, reversed: true), 100)
    }
    
    // MARK: - value by top offset
    
    func testValueForZeroTopOffset() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 0, minValue: 0, maxValue: 1, height: 100, reversed: false), 1)
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 0, minValue: 0, maxValue: 1, height: 100, reversed: true), 0)
    }
    
    func testValueForMaxTopOffset() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 100, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 100, minValue: 0, maxValue: 1, height: 100, reversed: true), 1)
    }
    
    func testValueForAverageTopOffset() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 30, minValue: 0, maxValue: 1, height: 100, reversed: false), 0.7)
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 30, minValue: 0, maxValue: 1, height: 100, reversed: true), 0.3)
    }
    
    func testValueForTopOffsetLessMin() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: -50, minValue: 0, maxValue: 1, height: 100, reversed: false), 1)
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: -50, minValue: 0, maxValue: 1, height: 100, reversed: true), 0)
    }
    
    func testValueForTopOffsetGreaterMax() {
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 150, minValue: 0, maxValue: 1, height: 100, reversed: false), 0)
        XCTAssertEqual(OffsetCalculator.valueBy(topOffset: 150, minValue: 0, maxValue: 1, height: 100, reversed: true), 1)
    }
}
