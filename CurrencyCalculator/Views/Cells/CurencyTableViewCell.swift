//
//  CurencyTableViewCell.swift
//  CurrencyCalculator
//
//  Created by Pawel on 5/23/19.
//  Copyright © 2019 Pawel. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    var currencyNameLabel = UILabel()
    var currencyCounterLabel = UILabel()
    var containerView = UIView()
    
    //MARK: Setup Cell
    
    func setupCellWith(currencyName: String, currencyCounter: Double) {
        currencyNameLabel.text = currencyName
        currencyCounterLabel.text = currencyCounter.stringWithTwoPlacesAfterComma()
        setupCell()
    }
    
    func setupCell() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        containerView.addSubview(currencyNameLabel)
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        currencyNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        currencyNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        containerView.addSubview(currencyCounterLabel)
        currencyCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyCounterLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        currencyCounterLabel.leadingAnchor.constraint(equalTo: currencyNameLabel.trailingAnchor).isActive = true
        currencyCounterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        currencyCounterLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}


