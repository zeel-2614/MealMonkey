//
//  NewPasswordViewController+UITextfieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

/// Extension of `NewPasswordViewController` to handle text field delegate methods.
extension NewPasswordViewController: UITextFieldDelegate {
    
    /// Called when the user taps the Return key on the keyboard.
    /// - Parameter textField: The text field whose return button was tapped.
    /// - Returns: `true` to indicate the text field should process the return action.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtNewPassword:
            // Move focus from "New Password" to "Confirm Password" field.
            txtNewPassword.resignFirstResponder()
            txtConfiemPassword.becomeFirstResponder()
            
        case txtConfiemPassword:
            // Dismiss keyboard when "Confirm Password" is done.
            txtConfiemPassword.resignFirstResponder()
            
        default:
            // Fallback: Dismiss keyboard for any other text fields.
            textField.resignFirstResponder()
        }
        return true
    }
}
