//
//  ApiKeyManager.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/26/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import Foundation

class ApiKeyManager {
    static var sharedManager = ApiKeyManager()
    
    func getApiKey() -> String {
        if let path = Bundle.main.path(forResource: Constants.Strings.APIKeyManager.keys, ofType: Constants.Strings.APIKeyManager.fileType) {
            if let keys = NSDictionary(contentsOfFile: path) {
                if let key = keys[Constants.Strings.APIKeyManager.apiKey] as? String {
                    return key
                }
            }
        }
        
        return ""
    }
}
