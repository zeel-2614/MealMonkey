//
//  NewPasswordViewController+UITextfieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtNewPassword:
            txtNewPassword.resignFirstResponder()
            txtConfiemPassword.becomeFirstResponder()
            
        case txtConfiemPassword:
            txtConfiemPassword.resignFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
