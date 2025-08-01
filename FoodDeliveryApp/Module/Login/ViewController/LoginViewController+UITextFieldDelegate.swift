//
//  LoginViewController+UITextFieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 01/08/25.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else{
            txtPassword.resignFirstResponder()
        }
        return true
    }
}
