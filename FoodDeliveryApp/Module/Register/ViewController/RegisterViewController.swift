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
        
        txtMobileNo.applyBorderStyle()
        txtMobileNo.setPadding(left: 34, right: 10)
        txtName.applyBorderStyle()
        txtName.setPadding(left: 34, right: 10)
        txtEmail.applyBorderStyle()
        txtEmail.setPadding(left: 34, right: 10)
        txtAddress.applyBorderStyle()
        txtAddress.setPadding(left: 34, right: 10)
        txtPassword.applyBorderStyle()
        txtPassword.setPadding(left: 34, right: 10)
        txtConfirmPassword.applyBorderStyle()
        txtConfirmPassword.setPadding(left: 34, right: 10)
        btnSignUp.applyBorderStyle()

        // Do any additional setup after loading the view.
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
