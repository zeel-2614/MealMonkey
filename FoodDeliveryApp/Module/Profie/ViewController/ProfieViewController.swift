//
//  ProfieViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/08/25.
//

import UIKit

class ProfieViewController: UIViewController {

    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var lblWelcomeMessage: UILabel!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSaveUser: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(profileCartBtn))
        
        viewImg.layer.cornerRadius = viewImg.frame.size.width/2
        viewImg.clipsToBounds = true
        
        EditStyle.setborder(textfields: [txtEmail,txtPassword,txtName,txtAddress,txtMobileNo, txtConfirmPassword, btnSaveUser])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword, txtName, txtAddress, txtMobileNo, txtConfirmPassword], paddingWidth: 34)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imgUser.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
   
    @objc func profileCartBtn() {
        
    }
    
    @objc func openImagePicker() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    @IBAction func btnEditProfileAction(_ sender: Any) {
    }
    
    @IBAction func btnSignOutAction(_ sender: Any) {
    }
    
    @IBAction func btnSaveUserAction(_ sender: Any) {
    }
}
