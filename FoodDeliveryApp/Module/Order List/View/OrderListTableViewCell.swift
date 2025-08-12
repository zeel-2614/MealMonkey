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
    
//    func configure(with products: [ProductModel], orderNumber: Int) {
//        lblOrderNumber.text = "Order No: \(orderNumber)"
//        if let firstProduct = products.first {
//            lblProductName.text = "First Product: \(firstProduct.strProductName)"
//            lblTotal.text = "Price: $\(String(format: "%.2f", firstProduct.doubleProductPrice))"
//            imgOrderedProduct.image = UIImage(named: firstProduct.strProductImage)
//        }
//    }
}
