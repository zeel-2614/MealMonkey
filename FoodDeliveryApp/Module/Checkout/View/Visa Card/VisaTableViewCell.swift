//
//  VisaTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class VisaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var stackViewVisa: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        stackViewVisa.layer.borderColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0).cgColor
        stackViewVisa.layer.borderWidth = 1.0
        stackViewVisa.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnSelectClick(_ sender: Any) {
    }
    
}
