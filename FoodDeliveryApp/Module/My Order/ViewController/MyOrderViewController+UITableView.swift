//
//  MyOrderViewController+UITableView.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import Foundation
import UIKit

extension MyOrderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath) as! MyOrderTableViewCell
        let product = orderProducts[indexPath.row]
        cell.lblProductName.text = product.strProductName
        cell.lblProductQty.text = " x \(product.intProductQty ?? 0)"
        cell.lblProductPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice * Double(product.intProductQty!)))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProducts.count
    }
}
