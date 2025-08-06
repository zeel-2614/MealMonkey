//
//  MenuTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 05/08/25.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with foodModel: MenuModel) {
        lblItemCount.text = foodModel.strItem
        lblTitle.text = foodModel.strTitle
        imgView.image = UIImage(named: foodModel.strImage)
    }
    
}
