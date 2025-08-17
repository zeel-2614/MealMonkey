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
    
    // Called when an image is selected from the image picker
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Set the selected and edited image to the profile picture
        imgProfile.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true) // Close the image picker
    }
}
