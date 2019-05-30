//
//  JSONParser.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//
import UIKit

class JSONParser: NSObject {
    static func jsonFromData(_ data: Data) -> [String:AnyObject]? {
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return dictionary as? [String:AnyObject]
        } catch _ {
            
        }
        return nil
    }
    
    static func currencyModelWithError(dictionary: [String: AnyObject]) -> NetworkingError {
        if let errorCode = dictionary[Constants.Strings.JSONParser.error]![Constants.Strings.JSONParser.errorCode] as? Int, let errorInfo = dictionary[Constants.Strings.JSONParser.error]![Constants.Strings.JSONParser.errorInfo] as? String {
            
            let error = NetworkingError(description: errorInfo, code: errorCode)
            
            return error
        }
        
        return NetworkingError(description: "Unknown error", code: 0)
        
    }
    
    static func createCurrencyModelFrom(dictionary: [String: AnyObject]) -> CurrencyModel {
        let isSuccess = dictionary[Constants.Strings.JSONParser.isSuccess] as! Bool
        let timeStamp = dictionary[Constants.Strings.JSONParser.timeStamp] as! Int
        let base = dictionary[Constants.Strings.JSONParser.baseCurrency] as! String
        let date = dictionary[Constants.Strings.JSONParser.date] as! String
        let currenciesDict = dictionary[Constants.Strings.JSONParser.currencies] as! [String: Double]
        var currencies = [Currency]()
        for (key, value) in currenciesDict {
            let currency = Currency(name: key, value: value)
            currencies.append(currency)
        }
        let currencyModel = CurrencyModel(success: isSuccess, timeStamp: timeStamp, baseCurrency: base, date: date, currencies: currencies)
        
        return currencyModel
    }
    
    static func isCurrencyModelDownloadedSucessfully(dictionary: [String: AnyObject]) -> Bool {
        let isSuccess = dictionary[Constants.Strings.JSONParser.isSuccess] as! Bool
        
        return isSuccess
    }
}
