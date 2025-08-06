//
//  MoreTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewMain.layer.cornerRadius = 7
        imgView.layer.cornerRadius = 28

        // Configure the view for the selected state
    }
    
    func configureCell(with model: MoreModel) {
        lblTitle.text = model.strTitle
        imgView.image = UIImage(named: model.strImage)
    }
    
}

