//
//  ProfileViewController+UITextFieldDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 14/08/25.
//

import Foundation
import UIKit

// MARK: - UITextFieldDelegate Methods
extension ProfileViewController: UITextFieldDelegate {
    
    // Called when the return key is pressed on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
            // If Name field is active, move to Email field
        case txtName:
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            
            // If Email field is active, move to Mobile Number field
        case txtEmail:
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
            
            // If Mobile Number field is active, move to Address field
        case txtMobileNo:
            txtMobileNo.resignFirstResponder()
            txtAddress.becomeFirstResponder()
            
            // If Address field is active, close the keyboard
        case txtAddress:
            txtAddress.resignFirstResponder()
            
            // For any other field, just close the keyboard
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imgProfile.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imgProfile.image = originalImage
        }
        dismiss(animated: true, completion: nil)
        updateSaveButtonState()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
