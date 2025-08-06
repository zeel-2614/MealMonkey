//
//  MenuViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 05/08/25.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var viewMainView: UIView!
    @IBOutlet weak var imgSideBar: UIImageView!
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var arrMenuItems: [MenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrMenuItems = MenuModel.getMenuData()
        
        tblMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        applyCornerRadiusTLBR()
        EditStyle.setborder(textfields: [txtSearch])
        EditStyle.setPadding(textFields: [txtSearch], paddingWidth: 34)

        // Do any additional setup after loading the view.
    }
    
    func applyCornerRadiusTLBR() {
        viewMainView.layer.cornerRadius = 28
        viewMainView.layer.maskedCorners = [
            .layerMinXMinYCorner, // top-left
            .layerMaxXMaxYCorner  // bottom-right
        ]
        viewMainView.clipsToBounds = true
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let foodModel = arrMenuItems[indexPath.row]
        cell.configureCell(with: foodModel)
        cell.backgroundColor = .clear
        return cell
    }
}
