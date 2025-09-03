//
//  Recent Items.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 11/08/25.
//

import Foundation

/// A helper class to manage and store recently viewed or interacted products.
/// Maintains a limited list of products, ensuring no duplicates and preserving most recent order.
class RecentItemsHelper {
    
    /// Shared singleton instance for accessing recent items helper.
    static let shared = RecentItemsHelper()
    
    /// Private initializer to enforce singleton usage.
    private init() {}
    
    /// Internal array storing the recent products.
    private var recentItems: [ProductModel] = []
    
    /// Maximum number of items to keep in recent list.
    private let maxItems = 7
    
    /// Adds a product to the recent items list.
    ///
    /// - Parameter product: The `ProductModel` instance to add.
    /// - Note: If the product already exists in the list, it will be moved to the front.
    func addProduct(_ product: ProductModel) {
        // Remove existing if present to avoid duplicates
        if let existingIndex = recentItems.firstIndex(where: { $0.intId == product.intId }) {
            recentItems.remove(at: existingIndex)
        }
        // Insert at beginning
        recentItems.insert(product, at: 0)
        
        // Keep only maxItems count
        if recentItems.count > maxItems {
            recentItems.removeLast()
        }
    }
    
    /// Retrieves the list of recent items.
    ///
    /// - Returns: An array of `ProductModel` representing the most recently added items.
    func getRecentItems() -> [ProductModel] {
        return recentItems
    }
    /// Clears all stored recent items.
    func clear() {
        recentItems.removeAll()
    }
}
