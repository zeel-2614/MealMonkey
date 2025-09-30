//
//  WishlistTableViewCell.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 16/08/25.
//

import UIKit

/// A custom table view cell used to display wishlist product details,
/// including name, category, price, and wishlist button state.
class WishlistTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    // MARK: - Properties
    /// Holds the product model associated with this cell.
    var wishlistProduct: Wishlist?
    var onWishlistUpdate: (() -> Void)?   // closure callback
    // MARK: - Lifecycle
    /// Called when the cell is loaded from the nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        // Initialization code
    }
    
    /// Called when the selection state of the cell changes.
    /// - Parameters:
    ///   - selected: A Boolean value indicating whether the cell is selected.
    ///   - animated: A Boolean value indicating whether the change is animated.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Configuration
    /// Configures the wishlist cell with the given product details.
    /// - Parameter product: The `ProductModel` object containing product information.
    func configure(with product: Wishlist) {
        self.wishlistProduct = product  // now a Wishlist object
        lblProductName.text = product.productName
        lblProductCategory.text = product.category
        lblProductPrice.text = "\(Main.cartAlertMessage.priceSymbol)\(product.price)"
        lblProductType.text = product.type
        lblProductQty.isHidden = true
        if let imageName = product.image {
            imageProduct.image = UIImage(named: imageName)
        }
        
        btnWishlist.setImage(UIImage(systemName: Main.Images.btnWishlist), for: .normal)
        btnWishlist.tintColor = .buttonBackground
        applyTheme()
    }
    
    // MARK: - Actions
    /// Handles wishlist button click to toggle product wishlist state.
    /// - Parameter sender: The button triggering the action.
    @IBAction func btnWishlistClick(_ sender: Any) {
        guard let product = wishlistProduct,
              let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        
        CoreDataManager.shared.removeFromWishlist(productId: Int(product.id), for: user)
        
        onWishlistUpdate?()  // refresh table
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Labels
        lblProductName.textColor = theme.labelTextColor
        lblProductCategory.textColor = theme.labelTextColor
        lblProductPrice.textColor = theme.labelTextColor
        lblProductType.textColor = theme.labelTextColor
        lblProductQty.textColor = theme.labelTextColor
        
        // Wishlist button
        btnWishlist.tintColor = theme.buttonColor
        
        // Background
        contentView.backgroundColor = theme.backgroundColor
    }
}
