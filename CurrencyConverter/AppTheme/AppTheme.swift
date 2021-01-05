//
//  AppTheme.swift
//  Currency Converter
//
//  Created by Sateesh on 05/01/2021.
//

import UIKit

enum AppFontName: String {
    case dubaiBold = "FS Truman Bold"
    case dubaiLight = "FS Truman Light"
    case dubaiRegular = "FS Truman"
}
class AppTheme: NSObject {
   @objc class func apply() {
        if let titleFont = UIFont(name: AppFontName.dubaiBold.rawValue, size: 20) {
            let attributes = [NSAttributedString.Key.font: titleFont]
            UINavigationBar.appearance().titleTextAttributes = attributes
        }
        let bgColor = UIColor(named: "Primary Color")
        UINavigationBar.appearance().backgroundColor = bgColor
        UINavigationBar.appearance().barTintColor = bgColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let barButtonItemAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        barButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
    }
   
}
