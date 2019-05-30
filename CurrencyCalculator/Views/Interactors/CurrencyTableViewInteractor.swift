//
//  CurrencyTableViewInteractor.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

protocol CurrencyTableViewBuisnessLogic: CurrencyGetterProtocol {
    func fetchCurrencies(request: CurrencyTableViewModel.Fetch.Request)
    func setBaseCurrency(request: CurrencyTableViewModel.Setup.Request)
    func recalculateValue(request: CurrencyTableViewModel.Recalculate.Request) -> Double
    func showNewCurrencyView(request: CurrencyTableViewModel.ShowNewView.Request)
    func showErrorAlert(request: CurrencyTableViewModel.ShowAlert.Request)
    
}

protocol CurrencyTableViewDataStore {
    var currencyModel: CurrencyModel { get set }
    var currencyCounter: Double { get set }
    var currentBaseCurrency: String { get set }
}

class CurrencyTableViewInteractor: CurrencyTableViewBuisnessLogic, CurrencyTableViewDataStore, CurrencyGetterProtocol, AddNewCurrencyProtocol {
    
    var baseCurrencies = ["EUR", "GBP", "PLN", "USD"]
    var presenter: CurrencyTableViewPresentationLogic?
    var worker = CurrencyTableViewWorker()
    
    //MARK : CurrencyTableViewDataStore
    
    var currencyCounter: Double = 1.0
    var currentBaseCurrency: String = "EUR"
    
    var currencyModel = CurrencyModel(success: false, timeStamp: 0, baseCurrency: "EUR", date: "", currencies: [Currency(name: "PLN", value: 1.2), Currency(name: "EUR", value: 1), Currency(name: "GBP", value: 0.82), Currency(name: "USD", value: 0.92)])
    
    //MARK: CurrencyTableViewBuisnessLogic
    
    func fetchCurrencies(request: CurrencyTableViewModel.Fetch.Request) {
        worker.interactor = self
        worker.fetch(request: request)
    }
    
    func setBaseCurrency(request: CurrencyTableViewModel.Setup.Request) {
        let baseCurrency: String
        let baseValue: Double
        
        if let name = request.currencyName, let value = request.currencyValue {
            baseCurrency = name
            baseValue = value
        } else {
            baseCurrency = currencyModel.baseCurrency
            baseValue = (currencyModel.getCurrency(name: baseCurrency)?.value)!
        }
        
        currentBaseCurrency = baseCurrency
        currencyCounter = baseValue
        
        baseCurrencies.insert(baseCurrency, at: 0)
        sortCurrencies()
        
        let response = CurrencyTableViewModel.Setup.Response(currencyName: baseCurrency, currencyValue: baseValue)
        presenter?.presentBaseCurrency(response: response)
    }
    
    func recalculateValue(request: CurrencyTableViewModel.Recalculate.Request) -> Double {
        if let selectedCurrencyValue = currencyModel.getCurrency(name: request.currencyName)?.value,
            let currentCurrencyCounter = currencyModel.getCurrency(name: currentBaseCurrency)?.value {
            let value1 = worker.changeValueToBaseCurrency(baseCurrencyValue: currencyCounter, counter: currentCurrencyCounter)
            let value2 = worker.changeBaseCurrencyToSelectedCurrency(baseCurrencyValue: value1, selectedCurrencyValue: selectedCurrencyValue)
            
            return value2
        }
        
        return 0
        
    }
    
    func showNewCurrencyView(request: CurrencyTableViewModel.ShowNewView.Request) {
        
        let popoverController = NewCurrencyViewController()
        popoverController.newCurrencyDelegate = self
        popoverController.view.backgroundColor = .white
        popoverController.modalPresentationStyle = .popover
        popoverController.modalTransitionStyle = .crossDissolve
        popoverController.preferredContentSize = CGSize(width: 250, height: 250)
        if let pop = popoverController.popoverPresentationController {
            let viewController = request.viewController
            pop.delegate = viewController
            pop.sourceRect = CGRect(x: viewController.addNewCurrencyButton.bounds.midX, y: viewController.addNewCurrencyButton.bounds.midY, width: 0, height: 0)
            pop.sourceView = viewController.addNewCurrencyButton
            pop.permittedArrowDirections = .any
            
        }

        presenter?.presentNewCurrencyView(response: CurrencyTableViewModel.ShowNewView.Response(newViewController: popoverController))
    }
    
    func showErrorAlert(request: CurrencyTableViewModel.ShowAlert.Request) {
        let alert = UIAlertController(title: Constants.Strings.CurrencyVC.alertTitle, message: request.error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Strings.CurrencyVC.okAlertAction, style: .default, handler: nil))
        if (request.error.code != 1) {
            alert.addAction(UIAlertAction(title: Constants.Strings.CurrencyVC.tryAgainAlertAction, style: .default, handler: { (action: UIAlertAction) in
                self.fetchCurrencies(request: CurrencyTableViewModel.Fetch.Request())
            }))
        }
        presenter?.presentAlert(response: CurrencyTableViewModel.ShowAlert.Response(alert: alert))
        
    }
    
    //MARK: NetworkingManagerDelegate
    
    func didDownloadCurrency(currencyModel: CurrencyModel) {
        let response = CurrencyTableViewModel.Fetch.Response(currencyModel: currencyModel, error: nil)
        self.currencyModel = currencyModel
        sortCurrencies()
        presenter?.presentFetchResults(response: response)
    }
    
    func didDownloadCurrencyWithError(_ error: NetworkingError?) {
        let response = CurrencyTableViewModel.Fetch.Response(currencyModel: nil, error: error)
        presenter?.presentFetchResults(response: response)
    }
    
    //MARK : Helpers
    
    func sortCurrencies() {
        
        var currencies = [Currency]()
        
        for base in baseCurrencies {
            if let index = currencyModel.currencies.index(where: {$0.name == base}) {
                currencies.append(currencyModel.currencies[index])
                currencyModel.currencies.remove(at: index)
            }
        }
        currencyModel.currencies.insert(contentsOf: currencies, at: 0)
        presenter?.refreshTableView(response: CurrencyTableViewModel.RefreshUI.Response())
    }
    
    //MARK: AddNewCurrencyDelegate
    
    func didAddNewCurrency(name: String, value: Double) {
        let currency = Currency(name: name, value: value)
        currencyModel.currencies.insert(currency, at: 0)
        presenter?.refreshTableView(response: CurrencyTableViewModel.RefreshUI.Response())
    }
    
    func didAddNewCurrencyWithError() {
        let error = NetworkingError(description: Constants.Strings.CurrencyVC.wrongNewCurrencyValueAlert, code: 1)
        showErrorAlert(request: CurrencyTableViewModel.ShowAlert.Request(error: error))
    }
}


