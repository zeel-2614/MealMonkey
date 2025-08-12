//
//  OrderListViewController+UITableViewDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import Foundation
import UIKit

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        let orderGroup = groupedOrders[indexPath.row]
        cell.configure(with: orderGroup.orderNumber, products: orderGroup.products)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedOrders.count
    }
}
