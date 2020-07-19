//
//  NumberFormatter+Covnenience.swift
//  CuvvaTechTest
//
//  Created by Dimitrios Chatzieleftheriou on 19/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static let receiptCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "£"
        return formatter
    }()
}
