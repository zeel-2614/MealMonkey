//
//  OffersTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 07/08/25.
//

import UIKit

class OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblCafeName: UILabel!
    @IBOutlet weak var lblRestroType: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblFoodType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configOffer(offer : offer)
    {
        imgView.image = UIImage(named: "\(offer.imageCafe)")
        lblCafeName.text = offer.strCafeName
        lblRattings.text = offer.strNoOfRatings
        lblRestroType.text = "\(offer.strCafeName)"
        lblFoodType.text = "\(offer.strFoodType)"
    }
    
}
