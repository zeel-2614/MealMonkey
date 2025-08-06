//
//  AboutUsTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 05/08/25.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRightSideTitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configaboutcell(about: AboutModel) {
        lblTitle.text = about.strText
        lblTitle2.isHidden = true
        lblRightSideTitle.isHidden = true
        btnStar.isHidden = true
    }
    
    func configNotificationcell(about: AboutModel) {
        lblTitle.text = about.strText
        btnStar.isHidden = true
        lblRightSideTitle.isHidden = true
        lblTitle2.text = about.strTimezone
    }
    
    func configInboxcell(about: AboutModel) {
        lblTitle.text = about.strText
        btnStar.isHidden = false
        lblRightSideTitle.text = about.strRightSideText
        lblTitle2.text = about.strText2
    }
}
