//
//  OrderListViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tblOrderList: UITableView!
    
    var orders: [[ProductModel]] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrOrders ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(myOrderBackBtn))
        
        // Do any additional setup after loading the view.
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
    }
    
    @objc func myOrderBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
}
