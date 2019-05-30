//
//  CurrencyTableViewModel.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

struct CurrencyTableViewModel {
    
    struct Fetch {
        
        struct Request {
        }
        
        struct Response {
            var currencyModel: CurrencyModel?
            var error: NetworkingError?
        }
        
        struct ViewModel {
            var error: NetworkingError?
        }
    }
    
    struct Setup {
        
        struct Request {
            var currencyName: String?
            var currencyValue: Double?
        }
        
        struct Response {
            var currencyName: String
            var currencyValue: Double
        }
        
        struct ViewModel {
            var currencyName: String
            var currencyValue: Double
        }
    }
    
    struct ShowAlert {
        struct Request {
            var error: NetworkingError
        }
        
        struct Response {
            var alert: UIAlertController
        }
        
        struct ViewModel {
            var alert: UIAlertController
        }
    }
    
    struct ShowNewView {
        
        struct Request {
            var viewController: CurrencyTableViewController
        }
        
        struct Response {
            var newViewController: UIViewController
        }
        
        struct ViewModel {
            var newViewController: UIViewController
        }
    }
    
    struct Recalculate {
        
        struct Request {
            var currencyName: String
        }
        
        struct Response {
            var currencyValue: Double
        }
        
        struct ViewModel {
            var currencyValue: Double
        }
    }
    
    struct RefreshUI {
        
        struct Request {
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
}

