//
//  CurrencyTableViewPresenter.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

protocol CurrencyTableViewPresentationLogic {
    func presentFetchResults(response: CurrencyTableViewModel.Fetch.Response)
    func presentBaseCurrency(response: CurrencyTableViewModel.Setup.Response)
    func presentNewCurrencyView(response: CurrencyTableViewModel.ShowNewView.Response)
    func presentAlert(response: CurrencyTableViewModel.ShowAlert.Response)
    func refreshTableView(response: CurrencyTableViewModel.RefreshUI.Response)
}

class CurrencyTableViewPresenter: CurrencyTableViewPresentationLogic {
    
    var viewController: CurrencyTableViewDisplayLogic?
    
    //MARK : CurrencyTableViewPresentationLogic
    
    func presentFetchResults(response: CurrencyTableViewModel.Fetch.Response) {
        if let error = response.error {
            viewController?.errorFetchedCurrencies(viewModel: CurrencyTableViewModel.Fetch.ViewModel(error: error))
        } else {
            viewController?.successFetchedCurrencies(viewModel:CurrencyTableViewModel.Fetch.ViewModel(error: nil))
        }
    }
    
    func presentBaseCurrency(response: CurrencyTableViewModel.Setup.Response) {
        let viewModel = CurrencyTableViewModel.Setup.ViewModel(currencyName: response.currencyName, currencyValue: response.currencyValue)
        viewController?.changeBaseCurrency(viewModel: viewModel)
    }
    
    func presentNewCurrencyView(response: CurrencyTableViewModel.ShowNewView.Response) {
        viewController?.showNewCurrencyPopover(viewModel: CurrencyTableViewModel.ShowNewView.ViewModel(newViewController: response.newViewController))
    }
    
    func presentAlert(response: CurrencyTableViewModel.ShowAlert.Response) {
        viewController?.showAlert(viewModel: CurrencyTableViewModel.ShowAlert.ViewModel(alert: response.alert))
    }
    
    func refreshTableView(response: CurrencyTableViewModel.RefreshUI.Response) {
        viewController?.refreshTableView(viewModel: CurrencyTableViewModel.RefreshUI.ViewModel())
    }
}


