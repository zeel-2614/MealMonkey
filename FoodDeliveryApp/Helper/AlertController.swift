//
//  AlertController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 02/09/25.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /// Displays a simple alert with a title, message, and a single "Ok" button.
    ///
    /// - Parameters:
    ///   - title: The title text to display at the top of the alert.
    ///   - message: The message body text to display in the alert.
    ///   - viewController: The `UIViewController` from which the alert will be presented.
    ///
    /// - Note: The "Ok" button dismisses the alert without performing any additional actions.
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
        }))
        viewController.present(alert, animated: true)
    }
}
