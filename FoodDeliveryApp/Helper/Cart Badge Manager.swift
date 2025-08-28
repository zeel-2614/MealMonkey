//
//  Cart Badge Manager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//

import Foundation

class CartBadgeManager {
    static let shared = CartBadgeManager()
    
    private init() {}
    
    private(set) var cartCount: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: .cartCountUpdated, object: nil)
        }
    }
    
    func updateCartCount(to count: Int) {
        cartCount = count
    }
    
    func incrementCartCount(by value: Int = 1) {
        cartCount += value
    }
    
    func resetCartCount() {
        cartCount = 0
    }
    
    func syncCartCount(for user: User) {
        let count = CoreDataManager.shared.fetchCartItems(for: user).count
        updateCartCount(to: count)
    }
}

extension Notification.Name {
    static let cartCountUpdated = Notification.Name("cartCountUpdated")
}
