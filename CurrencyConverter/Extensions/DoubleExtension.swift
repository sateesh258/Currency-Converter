//
//  DoubleExtension.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
