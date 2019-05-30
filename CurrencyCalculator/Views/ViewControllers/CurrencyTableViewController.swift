//
//  CurrencyTableViewController.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

protocol CurrencyTableViewDisplayLogic {
    func successFetchedCurrencies(viewModel: CurrencyTableViewModel.Fetch.ViewModel)
    func errorFetchedCurrencies(viewModel: CurrencyTableViewModel.Fetch.ViewModel)
    func changeBaseCurrency(viewModel: CurrencyTableViewModel.Setup.ViewModel)
    func showNewCurrencyPopover(viewModel: CurrencyTableViewModel.ShowNewView.ViewModel)
    func showAlert(viewModel: CurrencyTableViewModel.ShowAlert.ViewModel)
    func refreshTableView(viewModel: CurrencyTableViewModel.RefreshUI.ViewModel)
}

class CurrencyTableViewController: UIViewController, CurrencyTableViewDisplayLogic {
    
    var currencyBaseCurrencyView = BaseView()
    var currencyTableView = UITableView()
    var addNewCurrencyButton = UIButton()
    var interactor = CurrencyTableViewInteractor()
    
    // MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHelpers()
        setupViewElements()
        interactor.fetchCurrencies(request: CurrencyTableViewModel.Fetch.Request())
    }
    
    // MARK: Setup VC
    
    private func setupHelpers() {
        let viewController = self
        let interactor = CurrencyTableViewInteractor()
        let presenter = CurrencyTableViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func setupViewElements() {
        setupBaseCurrencyView()
        setupTableView()
        setupAddNewCurrencyButton()
        
        currencyTableView.translatesAutoresizingMaskIntoConstraints = false
        addNewCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        
        currencyBaseCurrencyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        currencyBaseCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currencyBaseCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currencyBaseCurrencyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Numbers.currencyBaseCurrencyViewHeightMultiplier).isActive = true
        
        currencyTableView.topAnchor.constraint(equalTo: currencyBaseCurrencyView.bottomAnchor).isActive = true
        currencyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currencyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        currencyTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Numbers.currencyTableViewHeightMultiplier).isActive = true
        
        addNewCurrencyButton.topAnchor.constraint(equalTo: currencyTableView.bottomAnchor).isActive = true
        addNewCurrencyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addNewCurrencyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addNewCurrencyButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Numbers.addNewCurrencyButtonHeightMultiplier).isActive = true
    }
    
    private func setupBaseCurrencyView() {
        currencyBaseCurrencyView = BaseView()
        view.addSubview(currencyBaseCurrencyView)
        currencyBaseCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        currencyBaseCurrencyView.setupBaseView(textFieldDelegate: self)
    }
    
    private func setupAddNewCurrencyButton() {
        addNewCurrencyButton = UIButton()
        
        addNewCurrencyButton.addTarget(self, action: #selector(addNewCurrency(sender:)), for: .touchUpInside)
        view.addSubview(addNewCurrencyButton)
        addNewCurrencyButton.setTitleColor(.black, for: .normal)
        addNewCurrencyButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Numbers.newCurrencyButtonFontSize)
        addNewCurrencyButton.setTitle(Constants.Strings.CurrencyVC.buttonTitle, for: .normal)
    }
    
    @objc func addNewCurrency(sender: UIButton) {
        interactor.showNewCurrencyView(request: CurrencyTableViewModel.ShowNewView.Request(viewController: self))
    }
    
    private func setupTableView() {
        currencyTableView = UITableView()
        currencyTableView.translatesAutoresizingMaskIntoConstraints = false
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        view.addSubview(currencyTableView)
    }
    
    // MARK: CurrencyTableViewDisplayLogic
    
    func successFetchedCurrencies(viewModel: CurrencyTableViewModel.Fetch.ViewModel) {
        DispatchQueue.main.async {
            self.interactor.setBaseCurrency(request: CurrencyTableViewModel.Setup.Request())
        }
        reloadTableView()
    }
    
    func errorFetchedCurrencies(viewModel: CurrencyTableViewModel.Fetch.ViewModel) {
        interactor.showErrorAlert(request: CurrencyTableViewModel.ShowAlert.Request(error: viewModel.error!))
    }
    
    func changeBaseCurrency(viewModel: CurrencyTableViewModel.Setup.ViewModel) {
        currencyBaseCurrencyView.selectedCurrencyNameLabel.text = viewModel.currencyName
        currencyBaseCurrencyView.selectedCurrencyTextField.text = String(viewModel.currencyValue)
        reloadTableView()
    }
    
    func showNewCurrencyPopover(viewModel: CurrencyTableViewModel.ShowNewView.ViewModel) {
        let popVC = viewModel.newViewController
        present(popVC, animated: true)
    }
    
    func showAlert(viewModel: CurrencyTableViewModel.ShowAlert.ViewModel) {
        present(viewModel.alert, animated: true)
    }
    
    func refreshTableView(viewModel: CurrencyTableViewModel.RefreshUI.ViewModel) {
        reloadTableView()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.currencyTableView.reloadData()
        }
    }
}

//MARK: TableView Data source

extension CurrencyTableViewController: UITableViewDataSource, UITableViewDelegate  {
    var dataSource: [Currency] {
        return interactor.currencyModel.currencies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currency = dataSource[indexPath.row]
        let cell = CurrencyTableViewCell()
        let newValue = interactor.recalculateValue(request: CurrencyTableViewModel.Recalculate.Request(currencyName: currency.name))
        cell.setupCellWith(currencyName: currency.name, currencyCounter: newValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = interactor.currencyModel.currencies[indexPath.row]
        let newCurrencyName = selectedCurrency.name
        interactor.setBaseCurrency(request: CurrencyTableViewModel.Setup.Request(currencyName: newCurrencyName, currencyValue: 1.0))
    }
}

//MARK: Text field delegate

extension CurrencyTableViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var currencyCounter = "1.0"
        if let text = textField.text {
            currencyCounter = text
        }
        if let value = Double(currencyCounter) {
            interactor.setBaseCurrency(request: CurrencyTableViewModel.Setup.Request(currencyName: interactor.currentBaseCurrency, currencyValue: value))
        } else {
            let error = NetworkingError(description: Constants.Strings.CurrencyVC.wrongValueAlertMsg, code: 1)
            interactor.showErrorAlert(request: CurrencyTableViewModel.ShowAlert.Request(error: error))
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

//MARK: PopoverPresentationControllerDelegate

extension CurrencyTableViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        view.alpha = Constants.Numbers.alphaWhenPopupVisible
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        view.alpha = Constants.Numbers.alphaWhenDismissPopup
    }
}

class BaseView: UIView {
    var selectedCurrencyNameLabel = UILabel()
    var selectedCurrencyTextField = UITextField()
    
    //MARK : Setup BaseView
    
    func setupBaseView(textFieldDelegate: UITextFieldDelegate) {
        selectedCurrencyTextField.delegate = textFieldDelegate
        addSubview(selectedCurrencyNameLabel)
        addSubview(selectedCurrencyTextField)
        selectedCurrencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        selectedCurrencyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedCurrencyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Numbers.leadingPadding).isActive = true
        selectedCurrencyNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Numbers.halfHeightConstant).isActive = true
        selectedCurrencyNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.Numbers.halfHeightConstant).isActive = true
        
        selectedCurrencyNameLabel.trailingAnchor.constraint(equalTo: selectedCurrencyTextField.leadingAnchor).isActive = true
        selectedCurrencyTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedCurrencyTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Numbers.trailingPadding).isActive = true
        selectedCurrencyTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.Numbers.halfHeightConstant).isActive = true
        
        selectedCurrencyNameLabel.text = "PLN"
        selectedCurrencyTextField.placeholder = Constants.Strings.CurrencyVC.valueTextFieldPlaceholder
        selectedCurrencyTextField.textAlignment = .right
        selectedCurrencyTextField.font = UIFont.systemFont(ofSize: Constants.Numbers.selectedCurrencyTextFieldFontSize)
        selectedCurrencyNameLabel.font = UIFont.systemFont(ofSize: Constants.Numbers.selectedCurrencyNameLabelFontSize)
        selectedCurrencyTextField.isUserInteractionEnabled = true
        selectedCurrencyTextField.keyboardType = .numbersAndPunctuation
    }
}

