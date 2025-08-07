//
//  DessertsTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/08/25.
//

import UIKit

class DessertsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRestroName: UILabel!
    @IBOutlet weak var lblRatting: UILabel!
    @IBOutlet weak var lblDessertName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgViewBottom: UIImageView!
    @IBOutlet weak var imgViewTop: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configDessert(dessert : Desserts){
        imgViewTop.image = UIImage(named: dessert.topImageName)
        imgViewBottom.image = UIImage(named: dessert.bottomImageName)
        lblDessertName.text = dessert.dessertName
        lblRatting.text = "\(dessert.rating)"
        lblRestroName.text = dessert.restaurantName
        lblCategory.text = dessert.category
    }
}
