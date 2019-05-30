//
//  NewCurrencyViewController.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/24/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

protocol AddNewCurrencyProtocol {
    func didAddNewCurrency(name: String, value: Double)
    func didAddNewCurrencyWithError()
}

class NewCurrencyViewController: UIViewController, UIPopoverControllerDelegate {
    
    var titleLabel = UILabel()
    var newCurrencyNameLabel = UILabel()
    var newCurrencyValueLabel = UILabel()
    var newCurrencyNameTextField = UITextField()
    var newCurrencyValueTextField = UITextField()
    var addNewCurrencyButton = UIButton()
    var newCurrencyDelegate: AddNewCurrencyProtocol?
    
    // MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewElements()
        view.layer.cornerRadius = 10
    }
    
    // MARK: VC Setup
    
    func setupViewElements() {
        setupButton()
        setupTextField(textField: newCurrencyNameTextField, text: Constants.Strings.CurrencyVC.nameTextFieldPlaceholder)
        setupTextField(textField: newCurrencyValueTextField, text: Constants.Strings.CurrencyVC.valueTextFieldPlaceholder)
        setupLabel(label: newCurrencyNameLabel, title: Constants.Strings.CurrencyVC.nameLabelText)
        setupLabel(label: titleLabel, title: Constants.Strings.CurrencyVC.newCurrencyViewTitle)
        titleLabel.font = UIFont.systemFont(ofSize: Constants.Numbers.newCurrencyTitleFontSize)
        setupLabel(label: newCurrencyValueLabel, title: Constants.Strings.CurrencyVC.newValueLabelText)
        newCurrencyValueTextField.keyboardType = .numbersAndPunctuation
        view.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Numbers.topPadding).isActive = true

        titleLabel.bottomAnchor.constraint(equalTo: newCurrencyNameLabel.topAnchor, constant: -Constants.Numbers.topPadding).isActive = true

        newCurrencyNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Numbers.leadingPadding).isActive = true
        newCurrencyNameLabel.centerYAnchor.constraint(equalTo: newCurrencyNameTextField.centerYAnchor).isActive = true
        newCurrencyNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Numbers.trailingPadding).isActive = true

        newCurrencyNameLabel.bottomAnchor.constraint(equalTo: newCurrencyValueLabel.topAnchor, constant: -Constants.Numbers.bottomPadding).isActive = true

        newCurrencyValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Numbers.leadingPadding).isActive = true
        newCurrencyValueLabel.centerYAnchor.constraint(equalTo: newCurrencyValueTextField.centerYAnchor).isActive = true
        newCurrencyValueTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Numbers.trailingPadding).isActive = true
        
        newCurrencyValueTextField.bottomAnchor.constraint(equalTo: addNewCurrencyButton.topAnchor, constant: -Constants.Numbers.bottomPaddingDouble).isActive = true
        
        addNewCurrencyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addNewCurrencyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.Numbers.bottomPadding).isActive = true
    }
    
    private func setupLabel(label: UILabel, title: String) {
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
    }
    
    private func setupButton() {
        addNewCurrencyButton = UIButton()
        addNewCurrencyButton.setTitleColor(.black, for: .normal)
        addNewCurrencyButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.Numbers.newCurrencyButtonFontSize)
        addNewCurrencyButton.setTitle(Constants.Strings.CurrencyVC.newCurrencyButtonText, for: .normal)
        addNewCurrencyButton.addTarget(self, action: #selector(addNewCurrency(sender:)), for: .touchUpInside)
        addNewCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addNewCurrencyButton)
    }
    
    private func setupTextField(textField: UITextField, text: String) {
        textField.delegate = self
        view.addSubview(textField)
        textField.placeholder = text
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: Actions
    
    @objc func addNewCurrency(sender: UIButton) {
        if let newName = newCurrencyNameTextField.text, let newValueString = newCurrencyValueTextField.text, let newValue = Double(newValueString) {
            newCurrencyDelegate?.didAddNewCurrency(name: newName, value: newValue)
            dissmissViewController()
        } else {
            dissmissViewController()
            newCurrencyDelegate?.didAddNewCurrencyWithError()
        }
        
    }
    
    func dissmissViewController() {
        dismiss(animated: true)
        
        if let popoverPres = popoverPresentationController {
            popoverPres.delegate?.popoverPresentationControllerDidDismissPopover!(popoverPres)
        }
    }
}

//MARK: UITextFieldDelegate

extension NewCurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    } 
}
