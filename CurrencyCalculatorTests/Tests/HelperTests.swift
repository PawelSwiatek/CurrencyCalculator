//
//  HelperTests.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/26/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import XCTest
@testable import CurrencyCalculator

class HelperTests: XCTestCase {
    
    func testDisplayingDoubleValue() {
        let exampleDouble = 1.2042
        let exampleDouble2 = 1.219
        let string = exampleDouble.stringWithTwoPlacesAfterComma()
        let string2 = exampleDouble2.stringWithTwoPlacesAfterComma()
        let exampleDouble3 = 1.212
        let string3 = exampleDouble3.stringWithTwoPlacesAfterComma()
        
        XCTAssertEqual(string, "1.20", "Double should be displayed with 2 numbers after comma")
        XCTAssertEqual(string2, "1.22", "Double should be displayed with 2 numbers after comma")
        XCTAssertEqual(string3, "1.21", "Double should be displayed with 2 numbers after comma")
    }
}

