//
//  UIAlertController+Extension.swift
//  CurrencyConverter
//
//  Created by Sateesh on 05/01/2021.
//

import UIKit

public extension UIAlertController {
    static func show(title: String?,
                     message: String?,
                     primaryButtonTitle: String,
                     primaryButtonAction: (() -> Void)? = nil,
                     secondaryButtonTitle: String? = nil,
                     secondaryButtonAction: (() -> Void)? = nil) {
        
        guard let topViewController = UIAlertController.topViewController() else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let primaryAction = UIAlertAction(title: primaryButtonTitle, style: .default) { (_) in
            primaryButtonAction?()
        }
        alertController.addAction(primaryAction)
        if let secondaryTitle = secondaryButtonTitle {
            let secondaryAction = UIAlertAction(title: secondaryTitle, style: .default) { (_) in
                secondaryButtonAction?()
            }
            alertController.addAction(secondaryAction)
        }
        topViewController.present(alertController, animated: true, completion: nil)
    }
    
   static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


