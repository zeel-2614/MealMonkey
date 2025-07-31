//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 31/07/25.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.title = "Log in"
        self.navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
    }
}
