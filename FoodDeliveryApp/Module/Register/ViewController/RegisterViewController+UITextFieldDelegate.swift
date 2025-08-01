//
//  RegisterViewController+UITextFieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 01/08/25.
//

import Foundation
import UIKit

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtName && textField.returnKeyType == .next{
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
        }
        else if textField == txtMobileNo && textField.returnKeyType == .next{
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
        }
        else if textField == txtAddress && textField.returnKeyType == .next{
            txtAddress.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword && textField.returnKeyType == .next{
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
        }
        else{
            txtConfirmPassword.resignFirstResponder()
        }
        return true
    }
}
