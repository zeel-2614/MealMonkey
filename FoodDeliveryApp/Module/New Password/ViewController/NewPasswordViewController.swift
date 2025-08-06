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
        
        EditStyle.setborder(textfields: [txtEmail,txtPassword, btnNext])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword], paddingWidth: 34)

        // Do any additional setup after loading the view.
    }

    @IBAction func btnNextClick(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: "FeaturesStoryboard", bundle: nil)
            if let fvc = storyboard.instantiateViewController(withIdentifier: "FeaturesViewController") as? FeaturesViewController {
                self.navigationController?.pushViewController(fvc, animated: true)
        }
    }
}
