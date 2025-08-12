//
//  OrderListTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var imgOrderedProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with orderNumber: Int, products: [ProductModel]) {
        lblOrderNumber.text = "Order No: \(orderNumber)"
        lblProductName.text = "\(products.count) items"
        
        let total = products.reduce(0) { $0 + $1.doubleProductPrice }
        lblTotal.text = "Total: $\(String(format: "%.2f", total))"
        
        if let firstProduct = products.first {
            imgOrderedProduct.image = UIImage(named: firstProduct.strProductImage)
        } else {
            imgOrderedProduct.image = nil
        }
    }
}
