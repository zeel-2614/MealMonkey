//
//  DessertsViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/08/25.
//

import UIKit

class DessertsViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    var arrdesserts : [Desserts] = Desserts.getDessertList()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitleWithBack("Dessert", target: self, action: #selector(backButtonTapped))
        setCartButton(target: self, action: #selector(cartTapped))
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
        
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cartTapped() {
        print("Cart tapped")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
