//
//  RegisterViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 01/08/25.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnBackToLogin: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EditStyle.setborder(textfields: [txtEmail,txtPassword,txtName,txtAddress,txtMobileNo, txtConfirmPassword, btnSignUp])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword, txtName, txtAddress, txtMobileNo, txtConfirmPassword], paddingWidth: 34)
    }

    @IBAction func btnSignUpClick(_ sender: Any) {
    }
    
    @IBAction func btnBackToLoginClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if ((storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController) != nil){
            self.navigationController?.popViewController(animated: true)
        }
    }
}
