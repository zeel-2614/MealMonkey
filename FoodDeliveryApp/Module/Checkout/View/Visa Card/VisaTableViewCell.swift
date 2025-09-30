//
//  VisaTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

/// A custom table view cell for displaying and selecting a Visa payment option.
class VisaTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var viewVisa: UIView!
    
    /// Called after the cell is loaded from the nib file.
    /// Used to apply initial styling and setup.
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        // Apply border, corner radius, and styling to the Visa view
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewVisa])
        // Initialization code
    }
    
    /// Sets the cell’s selected state.
    /// - Parameters:
    ///   - selected: A Boolean indicating whether the cell is selected.
    ///   - animated: A Boolean indicating whether the selection change should be animated.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        contentView.backgroundColor = theme.backgroundColor
        viewVisa.backgroundColor = theme.cardCellBackgroundColor
        viewVisa.layer.borderColor = theme.cardCellBorderColor.cgColor
        lblCardNo.textColor = theme.labelTextColor
        btnSelect.tintColor = theme.buttonColor
    }
}
