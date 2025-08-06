//
//  FeaturesCollectionViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import UIKit

class FeaturesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configFeatureCell(imgName: String) {
        imgView.image = UIImage(named: imgName)
    }
}
