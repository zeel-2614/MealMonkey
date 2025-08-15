//
//  SignupViewController+UITextfieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtName:
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            
        case txtEmail:
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
            
        case txtMobileNo:
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
            
        case txtAddress:
            txtAddress.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            
        case txtPassword:
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
