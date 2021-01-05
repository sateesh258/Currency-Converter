//
//  RatesListModel.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import Foundation

struct RatesListModel: Model {
    let base: String
    let rates: [String: Double]
    let date: String
    let error: String?
}

