//
//  Cart Badge Manager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//

import Foundation

/**
 `CartBadgeManager` is a singleton class responsible for managing the cart badge count across the app.
 
 This class:
 - Keeps track of the current cart item count.
 - Notifies observers whenever the cart count changes.
 - Provides methods to update, increment, reset, or synchronize the cart count with stored data.
 */
class CartBadgeManager {
    
    /// Shared singleton instance for accessing `CartBadgeManager` globally.
    static let shared = CartBadgeManager()
    
    /// Private initializer to enforce singleton usage.
    private init() {}
    
    /**
     Current number of items in the cart.
     
     - `didSet`: Posts a notification using `NotificationCenter` whenever the value changes.
     */
    private(set) var cartCount: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: .cartCountUpdated, object: nil)
        }
    }
    
    /**
     Updates the cart count to a specific value.
     
     - Parameter count: The new cart count value to set.
     
     - Example:
       ```swift
       CartBadgeManager.shared.updateCartCount(to: 5)
       ```
     */
    func updateCartCount(to count: Int) {
        cartCount = count
    }
    
    /**
     Increments the cart count by a specified value.
     
     - Parameter value: The number to increment the count by. Defaults to `1`.
     
     - Example:
       ```swift
       CartBadgeManager.shared.incrementCartCount()
       CartBadgeManager.shared.incrementCartCount(by: 3)
       ```
     */
    func incrementCartCount(by value: Int = 1) {
        cartCount += value
    }
    
    /**
     Resets the cart count to zero.
     
     - Example:
       ```swift
       CartBadgeManager.shared.resetCartCount()
       ```
     */
    func resetCartCount() {
        cartCount = 0
    }
    
    /**
     Synchronizes the cart count with the number of items saved in the database for a specific user.
     
     - Parameter user: The `User` object for which to fetch cart items.
     
     - Example:
       ```swift
       CartBadgeManager.shared.syncCartCount(for: currentUser)
       ```
     */
    func syncCartCount(for user: User) {
        let count = CoreDataManager.shared.fetchCartItems(for: user).count
        updateCartCount(to: count)
    }
}
/**
 Extension to define a notification name for observing cart count updates.
 
 - Usage:
   ```swift
   NotificationCenter.default.addObserver(self, selector: #selector(updateBadge), name: .cartCountUpdated, object: nil)
*/
extension Notification.Name {
/// Notification triggered whenever the cart count is updated.
static let cartCountUpdated = Notification.Name("cartCountUpdated")
}
