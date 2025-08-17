//
//  SignupViewController+UITextfieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

// MARK: - UITextFieldDelegate methods for SignUpViewController
extension SignUpViewController: UITextFieldDelegate {
    
    /// Handles the Return key press for each text field to navigate to the next input or dismiss the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
        // Move focus from Name to Email
        case txtName:
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        
        // Move focus from Email to Mobile Number
        case txtEmail:
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
        
        // Move focus from Mobile Number to Address
        case txtMobileNo:
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
        
        // Move focus from Address to Password
        case txtAddress:
            txtAddress.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        
        // Move focus from Password to Confirm Password
        case txtPassword:
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
        
        // When Confirm Password is done, dismiss keyboard
        case txtConfirmPassword:
            txtConfirmPassword.resignFirstResponder()
        
        // Fallback: dismiss keyboard for any other text field
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
