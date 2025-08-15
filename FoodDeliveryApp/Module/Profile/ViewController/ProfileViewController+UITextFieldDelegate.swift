//
//  ProfileViewController+UITextFieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

extension ProfileViewController: UITextFieldDelegate {
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
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
