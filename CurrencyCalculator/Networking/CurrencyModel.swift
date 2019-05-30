//
//  CurrencyModel.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

struct CurrencyModel {
    var success: Bool
    var timeStamp: Int
    var baseCurrency: String
    var date: String
    var currencies: [Currency]
    
    func getCurrency(name: String) -> Currency? {
       
        for currency in currencies {
           
            if currency.name == name {
               
                return currency
            }
        }
        
        return nil
    }
}

struct Currency {
    var name: String
    var value: Double
}

