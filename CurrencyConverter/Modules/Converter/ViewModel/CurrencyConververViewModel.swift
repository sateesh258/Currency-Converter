//
//  CurrencyConververViewModel.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import Foundation

class CurrencyConververterViewModel {
    var baseCurrency: String
    var selectedCurrency: CurrencyTableModel
    var baseCurrencyValue: Double = 1 {
        didSet {
            updateResult?(updatedResult())
        }
    }
    var updateResult: ((String) -> Void)?
    init(baseCurrency: String, selectedCurrency: CurrencyTableModel) {
        self.baseCurrency = baseCurrency
        self.selectedCurrency = selectedCurrency
    }
    func updatedResult() -> String {
        let result:Double = baseCurrencyValue * selectedCurrency.value
        return "\(result.rounded(toPlaces: 2))"
    }
    func selectedCurrencyCode() -> String {
        selectedCurrency.code
    }
    func selectedCurrencyValue() -> String {
        String(selectedCurrency.value)
    }
    func baseCurrencyStringValue() -> String {
        String(baseCurrencyValue)
    }
    func baseCurrencyValueChanged(_ value: String) {
        baseCurrencyValue = Double(value) ?? 0
    }
}
