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
        
        EditStyle.setborder(textfields: [txtEmail,btnSend])
        EditStyle.setPadding(textFields: [txtEmail], paddingWidth: 34)
    }
    
    @IBAction func btnSendClick(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let nvc = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController {
                self.navigationController?.pushViewController(nvc, animated: true)
        }
    }
    
}
