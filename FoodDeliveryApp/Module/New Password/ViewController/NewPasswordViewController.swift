//
//  NewPasswordViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.applyBorderStyle()
        txtEmail.setPadding(left: 34, right: 10)
        txtPassword.applyBorderStyle()
        txtPassword.setPadding(left: 34, right: 10)
        btnNext.applyBorderStyle()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnNextClick(_ sender: Any) {
    }
}
