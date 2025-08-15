//
//  LoginViewController+UITextfieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            
        case txtPassword:
            txtPassword.resignFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
