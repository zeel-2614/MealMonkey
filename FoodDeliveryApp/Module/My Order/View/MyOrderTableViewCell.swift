//
//  MyOrderTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

/// A custom table view cell that displays information about a product in an order.
class MyOrderTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    
    /// Called after the cell is loaded from the nib or storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Called when the cell’s selection state changes.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
