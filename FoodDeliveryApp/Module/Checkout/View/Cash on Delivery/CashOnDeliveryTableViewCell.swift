//
//  CashOnDeliveryTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

/// A custom table view cell used for displaying and selecting the "Cash on Delivery" payment option.
class CashOnDeliveryTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var viewCOD: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    /// Called after the cell has been loaded from the nib file.
    /// Used to apply initial UI styling and setup.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Apply border, corner radius, and styling to the COD view
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewCOD])
        applyTheme()
        // Initialization code
    }
    
    /// Sets the cell’s selected state.
    /// - Parameters:
    ///   - selected: A Boolean value indicating whether the cell is selected.
    ///   - animated: A Boolean value indicating whether the transition should be animated.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        contentView.backgroundColor = theme.backgroundColor
        viewCOD.backgroundColor = theme.cardCellBackgroundColor
        viewCOD.layer.borderColor = theme.cardCellBorderColor.cgColor
        btnSelect.tintColor = theme.buttonColor
    }
}
