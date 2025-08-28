//
//  OrderListTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit

/// A custom `UITableViewCell` subclass used to display order details in the order list.
class OrderListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var imgOrderedProduct: UIImageView!
    
    /**
     Called after the cell has been loaded from the nib file.
     This is where initial setup for the cell can be performed.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgOrderedProduct])
    }
    
    /**
     Called when the cell’s selection state changes.
     - Parameters:
     - selected: A Boolean value indicating whether the cell is now selected.
     - animated: A Boolean value indicating whether the change should be animated.
     This can be used to configure the view for the selected state.
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
