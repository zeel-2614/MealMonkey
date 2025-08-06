//
//  ProfileViewController + Delegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/08/25.
//

import Foundation
import UIKit

extension ProfieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgUser.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true)
    }
}
