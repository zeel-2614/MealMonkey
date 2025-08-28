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
    
    // Save context changes
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Failed to save context: \(error)")
            }
        }
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
    
    // MARK: - Card Methods
    func addCard(for user: User,
                 number: String,
                 expiryMonth: String,
                 expiryYear: String,
                 securityCode: String,
                 firstName: String,
                 lastName: String) {
        let card = Card(context: context)
        card.number = number
        card.expiryMonth = expiryMonth
        card.expiryYear = expiryYear
        card.securityCode = securityCode
        card.firstName = firstName
        card.lastName = lastName
        card.user = user
        saveContext()
    }
    
    // MARK: - Save Card
    func saveCard(for user: User, number: String) {
        let card = Card(context: context)
        card.number = number
        card.user = user
        
        do {
            try context.save()
            print("✅ Card saved successfully")
        } catch {
            print("❌ Failed to save card: \(error.localizedDescription)")
        }
    }
    
    func fetchCards(for user: User) -> [Card] {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteCard(_ card: Card) {
        context.delete(card)
        saveContext()
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
    func addOrUpdateCartItem(product: ProductModel, quantity: Int16, for user: User) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId == %d AND user == %@ AND (status == nil OR status == 'cart')", product.intId, user)
        
        do {
            if let existingItem = try context.fetch(request).first {
                // Increment quantity instead of overwriting
                existingItem.quantity += quantity
            } else {
                let cartItem = CartItems(context: context)
                cartItem.productId = Int64(product.intId)
                cartItem.productName = product.strProductName
                cartItem.price = product.doubleProductPrice
                cartItem.quantity = quantity
                cartItem.image = product.strProductImage
                cartItem.type = product.objProductType.rawValue
                cartItem.category = product.objProductCategory.rawValue
                cartItem.status = "cart"
                cartItem.user = user
            }
            try context.save()
        } catch {
            print("❌ Failed to add/update cart item: \(error)")
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
    func fetchCartItems(for user: User) -> [CartItems] {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND (status == nil OR status == 'cart')", user)
        request.sortDescriptors = [NSSortDescriptor(key: "productName", ascending: true)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch cart items: \(error)")
            return []
        }
    }
    // MARK: - Cart: Remove
    func removeCartItem(productId: Int, for user: User) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "productId == %d AND user == %@ AND (status == nil OR status == 'cart')", productId, user)
        
        do {
            let items = try context.fetch(request)
            items.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("❌ Failed to remove cart item: \(error)")
        }
    }
    
    func clearCart(for user: User) {
        fetchCartItems(for: user).forEach { context.delete($0) }
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@ AND status == 'cart'", user)
        do { try context.save() } catch { print("❌ Failed to clear cart: \(error)") }
    }
    
    // MARK: - Cart: Aggregate
    func cartTotals(for user: User) -> (itemCount: Int, total: Double) {
        let items = fetchCartItems(for: user)
        let count = items.reduce(0) { $0 + Int($1.quantity) }
        let total = items.reduce(0.0) { $0 + (Double($1.quantity) * $1.price) }
        return (count, total)
    }
    
    /// Save an order for the given user
    // MARK: - Order Management
    func placeOrder(products: [ProductModel], for user: User) {
        guard !products.isEmpty else { return }
        
        let order = Orders(context: context)
        order.date = Date()
        order.products = products.toData()
        order.userEmail = user.email
        saveContext()
        
        print("✅ Order placed for user: \(user.email ?? "")")
    }

    
    /// Fetch all orders for a user
    func fetchOrders(for user: User) -> [[ProductModel]] {
        let fetchRequest: NSFetchRequest<Orders> = Orders.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", user.email ?? "")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let orders = try context.fetch(fetchRequest)
            return orders.compactMap { $0.products?.toProducts() }
        } catch {
            print("❌ Failed to fetch orders: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteCartItem(item: CartItems, for user: User) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Error deleting cart item: \(error)")
        }
    }
    
    func addToWishlist(product: ProductModel, for user: User) {
        // Check if product already exists in wishlist for this user
        let request: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d AND user == %@", product.intId, user)
        
        do {
            let existing = try context.fetch(request)
            if existing.isEmpty {
                let wishlistItem = Wishlist(context: context)
                wishlistItem.id = Int64(product.intId)
                wishlistItem.productName = product.strProductName
                wishlistItem.price = product.doubleProductPrice
                wishlistItem.image = product.strProductImage
                wishlistItem.type = product.objProductType.rawValue
                wishlistItem.category = product.objProductCategory.rawValue
                wishlistItem.user = user  // link to user
                saveContext()
            }
        } catch {
            print("❌ Failed to add wishlist item: \(error)")
        }
    }
    
    func removeFromWishlist(productId: Int, for user: User) {
        let request: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d AND user == %@", productId, user)
        
        do {
            if let item = try context.fetch(request).first {
                context.delete(item)
                saveContext()
            }
        } catch {
            print("❌ Failed to remove wishlist item: \(error)")
        }
    }
    
    func fetchWishlist(for user: User) -> [Wishlist] {
        let request: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch wishlist: \(error)")
            return []
        }
    }
    
    func isInWishlist(productId: Int, for user: User) -> Bool {
        let request: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d AND user == %@", productId, user)
        
        do {
            return try context.fetch(request).first != nil
        } catch {
            print("❌ Error checking wishlist: \(error)")
            return false
        }
    }
}

extension Array where Element == ProductModel {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension Data {
    func toProducts() -> [ProductModel]? {
        return try? JSONDecoder().decode([ProductModel].self, from: self)
    }
}
