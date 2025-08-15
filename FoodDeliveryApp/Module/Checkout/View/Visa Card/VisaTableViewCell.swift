//
//  VisaTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class VisaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var viewVisa: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewVisa])
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
