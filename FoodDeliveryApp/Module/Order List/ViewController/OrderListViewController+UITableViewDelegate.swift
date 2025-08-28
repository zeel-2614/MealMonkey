//
//  OrderListViewController+UITableViewDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import Foundation
import UIKit

/// Extension of `OrderListViewController` to handle table view data source and delegate methods.
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    /**
     Configures and returns the cell for a given row in the table view.
     - Parameters:
     - tableView: The table view requesting the cell.
     - indexPath: The index path specifying the row and section.
     - Returns: A fully configured `OrderListTableViewCell` instance.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        
        // Each order is now [ProductModel]
        let products = orders[indexPath.row]
        
        // Show product names
        cell.lblProductName.text = products.map { $0.strProductName }.joined(separator: ", ")
        
        // Show total amount
        let total = products.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 1)) }
        cell.lblTotal.text = "Total: $\(total)"
        
        // Product Image
        cell.imgOrderedProduct.image = UIImage(named: products.first?.strProductImage ?? "placeholder")
        
        // Order number
        cell.lblOrderNumber.text = "Order #\(indexPath.row + 1)"
        
        return cell
    }
    
    /**
     Returns the number of rows in the given section.
     - Parameters:
     - tableView: The table view requesting the information.
     - section: The index number of the section.
     - Returns: The total number of orders.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    /**
     Handles the event when a row in the table view is selected.
     Navigates to `MyOrderViewController` to display details for the selected order.
     - Parameters:
     - tableView: The table view informing the delegate of the selection.
     - indexPath: The index path of the selected row.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MyOrderViewController") as? MyOrderViewController {
            
            // Pass the product array directly
            detailVC.orderProducts = orders[indexPath.row]
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
