//
//  RegisterViewController+UITextFieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 01/08/25.
//

import Foundation
import UIKit

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName where textField.returnKeyType == .next:
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            
        case txtEmail where textField.returnKeyType == .next:
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
            
        case txtMobileNo where textField.returnKeyType == .next:
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
            
        case txtAddress where textField.returnKeyType == .next:
            txtAddress.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            
        case txtPassword where textField.returnKeyType == .next:
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
            
        case txtConfirmPassword:
            txtConfirmPassword.resignFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
