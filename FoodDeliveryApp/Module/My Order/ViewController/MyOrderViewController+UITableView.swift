//
//  MyOrderViewController+UITableView.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import Foundation
import UIKit

/// Extension to handle table view data source and delegate methods for `MyOrderViewController`.
extension MyOrderViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Configures and returns the cell for a specific row in the order list.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path of the row.
    /// - Returns: A configured `MyOrderTableViewCell` displaying product details.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath) as! MyOrderTableViewCell
        let product = orderProducts[indexPath.row]
        cell.lblProductName.text = product.strProductName
        cell.lblProductQty.text = " x \(product.intProductQty ?? 0)"
        cell.lblProductPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice * Double(product.intProductQty!)))"
        return cell
    }
    
    /// Returns the number of rows in the table view (equal to the number of products in the order).
    /// - Parameters:
    ///   - tableView: The table view requesting the information.
    ///   - section: The index number of the section.
    /// - Returns: The number of rows (products) in the section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProducts.count
    }
}
