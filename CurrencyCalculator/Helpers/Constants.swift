//
//  Constants.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/26/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

struct Constants {
    struct Strings {
        struct Networking {
            static let baseURL = "http://data.fixer.io/api/latest"
            static let urlApiKey = "access_key"
        }
        
        struct APIKeyManager {
            static let keys = "Keys"
            static let fileType = "plist"
            static let apiKey = "apiKey"
            static let alertMsg = "Wrong Apikey!"
        }
        
        struct JSONParser {
            static let error = "error"
            static let errorCode = "code"
            static let errorInfo = "info"
            static let isSuccess = "success"
            static let timeStamp = "timestamp"
            static let baseCurrency = "base"
            static let date = "date"
            static let currencies = "rates"
        }
        
        struct CurrencyVC {
            static let buttonTitle = "Select to add new currency"
            static let wrongValueAlertMsg = "Value should be numbers only!"
            static let valueTextFieldPlaceholder = "Enter amount"
            static let nameTextFieldPlaceholder = "Enter name"
            static let nameLabelText = "New name"
            static let newCurrencyViewTitle = "Add new currency!"
            static let newValueLabelText = "New Value"
            static let newCurrencyButtonText = "Confirm"
            static let alertTitle = "Error occured"
            static let okAlertAction = "Ok"
            static let tryAgainAlertAction = "Try again"
            static let wrongNewCurrencyValueAlert = "Wrong value, currency not added!"
        }
    }
    
    struct Numbers {
        //MARK: Constraints
        static let currencyBaseCurrencyViewHeightMultiplier: CGFloat = 0.25
        static let currencyTableViewHeightMultiplier: CGFloat = 0.6
        static let addNewCurrencyButtonHeightMultiplier: CGFloat = 0.15
        
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = 20
        static let halfHeightConstant: CGFloat = 0.5
        static let bottomPadding: CGFloat = 20.0
        static let topPadding: CGFloat = 20.0
        static let bottomPaddingDouble: CGFloat = 40.0
        //MARK: Fonts
        static let newCurrencyButtonFontSize: CGFloat = 20
        static let newCurrencyTitleFontSize: CGFloat = 20
        static let selectedCurrencyTextFieldFontSize: CGFloat = 25
        static let selectedCurrencyNameLabelFontSize: CGFloat = 20
        
        //MARK: Alpha
        static let alphaWhenPopupVisible: CGFloat = 0.7
        static let alphaWhenDismissPopup: CGFloat = 1.0
    }
}
