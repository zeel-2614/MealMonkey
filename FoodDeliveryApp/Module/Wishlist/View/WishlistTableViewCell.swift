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
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    // MARK: - Properties
    /// Holds the product model associated with this cell.
    var wishlistProduct: ProductModel?
    
    // MARK: - Lifecycle
    /// Called when the cell is loaded from the nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
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
    func configure(with product: ProductModel) {
        self.wishlistProduct = product
        lblProductName.text = product.strProductName
        lblProductCategory.text = product.objProductCategory.rawValue
        lblProductPrice.text = "\(product.doubleProductPrice)"
        imageProduct.image = UIImage(named: product.strProductImage)
        
        // Always show filled heart when in wishlist
        btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        btnWishlist.tintColor = .buttonBackground
    }
    
    // MARK: - Actions
    /// Handles wishlist button click to toggle product wishlist state.
    /// - Parameter sender: The button triggering the action.
    @IBAction func btnWishlistClick(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let product = wishlistProduct else { return }
        
        if let index = appDelegate.arrWishlist.firstIndex(where: { $0.intId == product.intId }) {
            // Remove
            appDelegate.arrWishlist.remove(at: index)
            btnWishlist.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            // Add
            appDelegate.arrWishlist.append(product)
            btnWishlist.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        saveWishlist(appDelegate.arrWishlist)
    }
}
