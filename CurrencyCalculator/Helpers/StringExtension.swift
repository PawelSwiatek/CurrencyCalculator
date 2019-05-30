//
//  StringExtension.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/25/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import Foundation

extension Double {
    
    func stringWithTwoPlacesAfterComma() -> String {
        return String(format: "%.2f", self)
    }
}
