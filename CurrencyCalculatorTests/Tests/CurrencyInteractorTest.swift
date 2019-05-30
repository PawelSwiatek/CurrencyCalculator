//
//  CurrencyInteractorTest.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/26/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import XCTest
@testable import CurrencyCalculator

class CurrencyInteractorTest: XCTestCase {
    
    let interactor = CurrencyTableViewInteractor()
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetBaseCurrency() {
        let testCurrencyName = "Name"
        let testCurrencyValue = 1.23
        let request = CurrencyTableViewModel.Setup.Request(currencyName: testCurrencyName, currencyValue: testCurrencyValue)

        interactor.setBaseCurrency(request: request)
        let currencyName = interactor.currentBaseCurrency
        let currencyValue = interactor.currencyCounter
        
        XCTAssertEqual(currencyName, testCurrencyName, "viewController shouldn't be nil")
        XCTAssertEqual(currencyValue, testCurrencyValue, "viewController shouldn't be nil")
    }
    
    func testRecalculateCurrency() {
        interactor.currencyModel.currencies = [Currency(name: "EUR", value: 1 ), Currency(name: "PLN", value: 2), Currency(name: "GBP", value: 3)]
        interactor.currencyModel.baseCurrency = "EUR"
        interactor.currentBaseCurrency = "PLN"
        interactor.currencyCounter = 4.0
        let request = CurrencyTableViewModel.Recalculate.Request(currencyName: "GBP")

        let gbpValue = interactor.recalculateValue(request: request)
        
         XCTAssertEqual(gbpValue, 6.0, "4 PLN should be equal to 6 GBP acording to those example currencies data")

    }
    
}
