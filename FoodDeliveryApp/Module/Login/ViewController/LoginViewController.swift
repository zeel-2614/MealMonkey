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
        
        EditStyle.setborder(textfields: [txtEmail,txtPassword,btnLogin,btnLoginWithGoogle,btnLoginWithFacebook])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword], paddingWidth: 34)
    }

    @IBAction func btnLoginClick(_ sender: Any) {
        showMainTabBar()
    }
    
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? UITabBarController {
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
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
