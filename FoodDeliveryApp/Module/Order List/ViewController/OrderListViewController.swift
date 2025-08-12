//
//  OrderListViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tblOrderList: UITableView!
    
    var orders: [ProductModel] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrOrders ?? []
    }
    
    var groupedOrders: [(orderNumber: Int, products: [ProductModel])] {
        let grouped = Dictionary(grouping: orders) { $0.orderNumber ?? 0 }
        return grouped.map { (orderNumber: $0.key, products: $0.value) }
                      .sorted { $0.orderNumber < $1.orderNumber }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
    }
}
