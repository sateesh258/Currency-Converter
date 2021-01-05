//
//  CountriesListModel.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import Foundation

struct CountriesListModel: Decodable {
    let countries: [Country]?
}

struct Country: Decodable {
    let countryCode: String
    let countryName: String
    let currencyCode: String
}
