//
//  OrderListViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var lblEmptyOrder: UILabel!
    @IBOutlet weak var tblOrderList: UITableView!
    
    var orders: [[ProductModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orders = loadOrdersFromUserDefaults()
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(myOrderBackBtn))
        
        // Do any additional setup after loading the view.
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
    }
    
    @objc func myOrderBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateEmptyOrderUI() {
        let isOrderEmpty = orders.isEmpty
        lblEmptyOrder.isHidden = !isOrderEmpty
        tblOrderList.isHidden = isOrderEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEmptyOrderUI()
        tblOrderList.reloadData()
    }
}
