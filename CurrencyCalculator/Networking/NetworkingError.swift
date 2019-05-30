//
//  NetworkingError.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/24/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import Foundation

protocol NetworkingErrorProtocol: LocalizedError {
    var code: Int { get set }
    var description: String { get set }
}

struct NetworkingError: NetworkingErrorProtocol {
    var description: String
    var code: Int
}

