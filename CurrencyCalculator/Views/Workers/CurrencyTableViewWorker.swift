//
//  CurrencyTableViewWorker.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

class CurrencyTableViewWorker {
    var interactor: CurrencyTableViewBuisnessLogic?
    
    //MARK: Worker fetch request
    
    func fetch(request: CurrencyTableViewModel.Fetch.Request) {
        NetworkingManager.sharedManager.delegate = interactor
        NetworkingManager.sharedManager.getCurrencies()
    }
    
    //MARK: Work currency recalculation helpers
    
    func changeValueToBaseCurrency(baseCurrencyValue: Double, counter: Double) -> Double {
        let newValue = baseCurrencyValue / counter
        
        return newValue
        
    }
    
    func changeBaseCurrencyToSelectedCurrency(baseCurrencyValue: Double, selectedCurrencyValue: Double) -> Double {
        let newValue = baseCurrencyValue * selectedCurrencyValue
        
        return newValue
    }
    
}

