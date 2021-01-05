//
//  AppURL.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import Foundation


struct AppUrl {
    
    private  static let Domain = Domains.Prod
    private  static let BaseURL = Domain
    
    private struct Domains {
        static let Prod = "https://api.exchangeratesapi.io/"
        static let Dev = "https://api.exchangeratesapi.io/"
    }
    
    static let currencyList = BaseURL + "latest"
}
