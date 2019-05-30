//
//  NetworkingManager.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//
import UIKit

protocol CurrencyGetterProtocol {
    func didDownloadCurrency(currencyModel: CurrencyModel)
    func didDownloadCurrencyWithError(_ error: NetworkingError?)
}

class NetworkingManager {
    static var sharedManager = NetworkingManager()
    var delegate: CurrencyGetterProtocol?
    
    private let openCurrencyMapBaseURL = "http://data.fixer.io/api/latest"
    
    func getCurrencies() {
        let apiKey = ApiKeyManager.sharedManager.getApiKey()
       
        if !apiKey.isEmpty {
            let session = URLSession.shared
            
            let currencyRequestURL = URL(string: "\(Constants.Strings.Networking.baseURL)?\(Constants.Strings.Networking.urlApiKey)=\(apiKey)")
            let dataTask = session.dataTask(with: currencyRequestURL!) {
                (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    let err = NetworkingError(description: error.localizedDescription, code: 0)
                    self.delegate?.didDownloadCurrencyWithError(err)
                } else {
                    if let dictionary = JSONParser.jsonFromData(data!) {
                        if JSONParser.isCurrencyModelDownloadedSucessfully(dictionary: dictionary) {
                            let currencyModel = JSONParser.createCurrencyModelFrom(dictionary: dictionary)
                            self.delegate?.didDownloadCurrency(currencyModel: currencyModel)
                        } else {
                            let error = JSONParser.currencyModelWithError(dictionary: dictionary)
                            self.delegate?.didDownloadCurrencyWithError(error)
                        }
                    }
                }
            }
            dataTask.resume()
        } else {
            let err = NetworkingError(description: Constants.Strings.APIKeyManager.alertMsg, code: 0)
            self.delegate?.didDownloadCurrencyWithError(err)
        }
    }
}



