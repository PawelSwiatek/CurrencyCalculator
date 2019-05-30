//
//  CurrencyViewControllerTests.swift
//  CurrencyCalculatorUITests
//
//  Created by Pawel on 5/26/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import XCTest
@testable import CurrencyCalculator

class CurrencyViewControllerTests: XCTestCase {
    
    let currencyVC: CurrencyTableViewController = CurrencyTableViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testViewCurrencyControllerSetup() {
        currencyVC.viewDidLoad()
        let ineractor = currencyVC.interactor
        let presenter = ineractor.presenter
        let baseView = currencyVC.currencyBaseCurrencyView
        let tableView = currencyVC.currencyTableView
        let button = currencyVC.addNewCurrencyButton
        
        XCTAssertNotNil(ineractor, "viewController shouldn't be nil")
        XCTAssertNotNil(presenter, "presenter shouldn't be nil")
        XCTAssertNotNil(baseView, "baseView shouldn't be nil")
        XCTAssertNotNil(tableView, "tableView shouldn't be nil")
        XCTAssertNotNil(button, "button shouldn't be nil")
    }
    
    func testChangingBaseCurrency() {
        currencyVC.changeBaseCurrency(viewModel: CurrencyTableViewModel.Setup.ViewModel(currencyName: "Base", currencyValue: 1.22))
        
        XCTAssertEqual(currencyVC.currencyBaseCurrencyView.selectedCurrencyNameLabel.text, "Base", "viewController shouldn't be nil")
        XCTAssertEqual(currencyVC.currencyBaseCurrencyView.selectedCurrencyTextField.text, "1.22", "viewController shouldn't be nil")
        
    }
    

}
