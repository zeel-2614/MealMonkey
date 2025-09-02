//
//  WishlistViewController+UITableViewDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 16/08/25.
//

import Foundation
import UIKit

/// Extension to handle `UITableViewDelegate` and `UITableViewDataSource` methods
/// for displaying the wishlist items inside the `WishlistViewController`.
extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows (wishlist items) to display in the table view.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The index number of the section.
    /// - Returns: The number of wishlist products stored in `arrWishlist`.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistProduct.count
    }
    
    /// Provides the cell to display for a given row in the table view.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path locating the row in the table view.
    /// - Returns: A configured `WishlistTableViewCell` containing wishlist product data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.wishlistTableViewCell, for: indexPath) as! WishlistTableViewCell
        let product = wishlistProduct[indexPath.row]
        cell.configure(with: product)
        cell.onWishlistUpdate = { [weak self] in
            self?.loadWishlist()
        }
        return cell
    }
}
