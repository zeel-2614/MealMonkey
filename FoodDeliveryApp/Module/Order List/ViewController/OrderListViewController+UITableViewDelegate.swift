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
        
        let order = orders[indexPath.row]
        let firstProductName = order.first?.strProductName ?? "No Product"
        
        // Calculate total price for all products in the order
        let totalPrice = order.reduce(0.0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        
        // Populate cell labels and image
        cell.lblOrderNumber.text = "Order No : \(indexPath.row + 1)"
        cell.lblProductName.text = firstProductName
        cell.lblTotal.text = "$\(String(format: "%.2f", totalPrice))"
        if let imgName = order.first?.strProductImage {
            cell.imgOrderedProduct.image = UIImage(named: imgName)
        }
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
            detailVC.orderProducts = orders[indexPath.row] // Pass the selected order
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    /**
     Saves the given list of orders to `UserDefaults`.
     - Parameter orders: A two-dimensional array of `ProductModel` representing the orders.
     */
    func saveOrdersToUserDefaults(_ orders: [[ProductModel]]) {
        let ordersArray = orders.map { order in
            order.map { product in
                productToDict(product) // Reuse the helper function to convert to dictionary
            }
        }
        UserDefaults.standard.set(ordersArray, forKey: "orders")
    }
    
    /**
     Loads the list of orders from `UserDefaults`.
     - Returns: A two-dimensional array of `ProductModel` representing the saved orders.
     */
    func loadOrdersFromUserDefaults() -> [[ProductModel]] {
        guard let savedOrders = UserDefaults.standard.array(forKey: "orders") as? [[[String: Any]]] else {
            return []
        }
        return savedOrders.map { orderDictArray in
            orderDictArray.map { dictToProduct($0) } // Reuse the helper to convert dictionary back to model
        }
    }
}
