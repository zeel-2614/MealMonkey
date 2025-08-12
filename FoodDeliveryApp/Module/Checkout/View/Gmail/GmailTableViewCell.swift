//
//  GmailTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class GmailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewGmail: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var stackViewGmail: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewGmail])
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnSelectClick(_ sender: Any) {
    }
}
