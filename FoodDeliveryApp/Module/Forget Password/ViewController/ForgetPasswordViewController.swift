//
//  ForgetPasswordViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 01/08/25.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.layer.cornerRadius = 28
        txtEmail.setPadding(left: 34, right: 10)
        btnSend.applyBorderStyle()

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
    @IBAction func btnSendClick(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let nvc = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController {
                self.navigationController?.pushViewController(nvc, animated: true)
        }
    }
    
}
