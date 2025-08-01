//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 31/07/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLoginWithGoogle: UIButton!
    @IBOutlet weak var btnLoginWithFacebook: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.applyBorderStyle()
        txtEmail.applyBorderStyle()
        txtEmail.setPadding(left: 34, right: 10)
        txtPassword.applyBorderStyle()
        txtPassword.setPadding(left: 34, right: 10)
        btnLoginWithFacebook.applyBorderStyle()
        btnLoginWithGoogle.applyBorderStyle()
    }
    
    @IBAction func btnLoginClick(_ sender: Any) {
    }
    
    @IBAction func btnForgetPasswordClick(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let fvc = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController {
                self.navigationController?.pushViewController(fvc, animated: true)
        }
    }
    
    @IBAction func btnLoginWithFacebookClick(_ sender: Any) {
    }
    
    @IBAction func btnLoginWithGoogleClick(_ sender: Any) {
    }
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let rvc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
                self.navigationController?.pushViewController(rvc, animated: true)
        }
    }
}
