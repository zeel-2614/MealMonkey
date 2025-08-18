//
//  LoginViewController+UITextfieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

// MARK: - UITextFieldDelegate methods for LoginViewController
extension LoginViewController: UITextFieldDelegate {
    
    /// Handles the "Return" key press on the keyboard for each text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
        case txtEmail:
            // When the email field's return key is pressed:
            // 1. Hide the keyboard for email field
            txtEmail.resignFirstResponder()
            // 2. Move focus to the password field
            txtPassword.becomeFirstResponder()
            
        case txtPassword:
            // When the password field's return key is pressed:
            // Hide the keyboard for password field
            txtPassword.resignFirstResponder()
            
        default:
            // For any other text field, just hide the keyboard
            textField.resignFirstResponder()
        }
        
        // Return true to allow default "Return" behavior
        return true
    }
}
