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
        let order = orders[indexPath.row]
        let firstProductName = order.first?.strProductName ?? "No Product"
        
        // Total price
        let totalPrice = order.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        
        cell.lblOrderNumber.text = "Order No : \(indexPath.row + 1)"
        cell.lblProductName.text = firstProductName
        cell.lblTotal.text = "$\(String(format: "%.2f", totalPrice))"
        if let imgName = order.first?.strProductImage {
            cell.imgOrderedProduct.image = UIImage(named: imgName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
            detailVC.orderProducts = orders[indexPath.row] // Pass the selected order
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
