//
//  Core Data Manager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 18/08/25.
//

import UIKit
import CoreData


final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    
    // MARK: - Context
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Current User
    func getCurrentUser() -> User? {
        guard let email = SessionManager.getEmail(), !email.isEmpty else { return nil }
        return fetchUser(byEmail: email)
    }
    
    
    func fetchUser(byEmail email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }
    
    /// Optionally create the user if missing
    func getOrCreateCurrentUser() -> User? {
        guard let email = SessionManager.getEmail(), !email.isEmpty else { return nil }
        if let existing = fetchUser(byEmail: email) { return existing }
        let user = User(context: context)
        user.email = email
        do { try context.save() } catch { print("Failed create user:", error) }
        return user
    }
    
    // MARK: - Cart: Add / Update (Upsert)
    /// Adds a product or increases its quantity if it already exists.
    func addOrIncrementCartItem(product: ProductModel, delta quantityDelta: Int16 = 1, for user: User) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId == %d AND user == %@", product.intId, user)
        
        
        do {
            if let existing = try context.fetch(request).first {
                existing.quantity = max(1, existing.quantity + quantityDelta)
            } else {
                let item = CartItems(context: context)
                item.productId = Int64(product.intId)
                item.productName = product.strProductName
                item.price = product.doubleProductPrice
                item.quantity = max(1, quantityDelta)
                item.image = product.strProductImage
                item.type = product.objProductType.rawValue   // ✅ save type
                item.category = product.objProductCategory.rawValue // ✅ save category
                item.user = user
            }
            try context.save()
        } catch {
            print("❌ addOrIncrementCartItem error:", error)
        }
    }
    
    /// Sets an exact quantity for a product (deletes if qty <= 0)
    func setQuantity(productId: Int, to qty: Int16, for user: User) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId == %d AND user == %@", productId, user)
        do {
            if let item = try context.fetch(request).first {
                if qty <= 0 {
                    context.delete(item)
                } else {
                    item.quantity = qty
                }
                try context.save()
            }
        } catch { print("❌ setQuantity error:", error) }
    }
    
    // MARK: - Cart: Fetch
    func fetchCart(for user: User) -> [CartItems] {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        request.sortDescriptors = [NSSortDescriptor(key: "productName", ascending: true)]
        do { return try context.fetch(request) } catch {
            print("❌ fetchCart error:", error); return []
        }
    }
    
    // MARK: - Cart: Remove
    func removeCartItem(productId: Int, for user: User) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId == %d AND user == %@", productId, user)
        do {
            try context.fetch(request).forEach { context.delete($0) }
            try context.save()
        } catch { print("❌ removeCartItem error:", error) }
    }
    
    
    func clearCart(for user: User) {
        fetchCart(for: user).forEach { context.delete($0) }
        do { try context.save() } catch { print("❌ clearCart error:", error) }
    }
    
    
    // MARK: - Cart: Aggregate
    func cartTotals(for user: User) -> (itemCount: Int, total: Double) {
        let items = fetchCart(for: user)
        let count = items.reduce(0) { $0 + Int($1.quantity) }
        let total = items.reduce(0.0) { $0 + (Double($1.quantity) * $1.price) }
        return (count, total)
    }
    
    /// Save an order for the given user
    func placeOrder(from cartItems: [CartItems], for user: User) {
        guard !cartItems.isEmpty else { return }
        
        let order = Orders(context: context)
        order.date = Date()
        order.orderNumber = UUID().uuidString
        order.totalPrice = cartItems.reduce(0.0) { $0 + (Double($1.quantity) * $1.price) }
        order.userEmail = user.email
        order.users = user
        
        // For simplicity, just store first product’s image & name
        if let firstItem = cartItems.first {
            order.productName = firstItem.productName
            order.productImage = firstItem.image
        }
        
        do {
            try context.save()
            clearCart(for: user)  // ✅ empty cart after order placed
        } catch {
            print("❌ placeOrder error:", error)
        }
    }
    
    /// Fetch all orders for a user
    func fetchOrders(for user: User) -> [Orders] {
        let request: NSFetchRequest<Orders> = Orders.fetchRequest()
        request.predicate = NSPredicate(format: "users == %@", user)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do { return try context.fetch(request) } catch {
            print("❌ fetchOrders error:", error)
            return []
        }
    }
    
    /// Remove all orders (optional helper)
    func clearOrders(for user: User) {
        fetchOrders(for: user).forEach { context.delete($0) }
        do { try context.save() } catch { print("❌ clearOrders error:", error) }
    }
}
