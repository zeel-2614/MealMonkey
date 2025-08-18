//
//  GmailTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

/// A custom table view cell for displaying and selecting the Gmail payment option.
class GmailTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var viewGmail: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var stackViewGmail: UIStackView!
    
    /// Called after the cell is loaded from the nib file.
    /// Used to apply initial styling and configuration.
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Apply border, corner radius, and styling to the Gmail view
        viewStyle.viewStyle(cornerRadius: 6, borderWidth: 1, borderColor: .labelPrimary, textField: [viewGmail])
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
}
