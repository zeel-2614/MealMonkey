//
//  Core Data Manager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 18/08/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchUserCart(email: String) -> [CartItems] {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "userEmail == %@", email)
        
        do {
            return try context.fetch(request)   // ✅ use context
        } catch {
            print("❌ Failed to fetch cart items: \(error)")
            return []
        }
    }
    
    func clearCart(for email: String) {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "userEmail == %@", email)
        
        do {
            let items = try context.fetch(request)
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("❌ Failed to clear cart: \(error)")
        }
    }
    
    
    //     Add product to user's cart
    func addToCart(user: User, product: ProductModel, quantity: Int16 = 1) {
        let cartItem = CartItems(context: context)
        cartItem.productId = Int64(product.intId)
        cartItem.productName = product.strProductName
        cartItem.price = product.doubleProductPrice
        cartItem.quantity = quantity
        cartItem.image = product.strProductImage
        cartItem.user = user
        
        saveContext()
    }
    
    // Fetch all cart items for a user
    func fetchCart(for user: User) -> [CartItems] {
        let request: NSFetchRequest<CartItems> = CartItems.fetchRequest()
        request.predicate = NSPredicate(format: "user == %@", user)
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch cart items: \(error)")
            return []
        }
    }
    
    // Remove a cart item
    func removeCartItem(_ item: CartItems) {
        context.delete(item)
        saveContext()
    }
    
    // Clear all cart items for a user
    func clearCart(for user: User) {
        let items = fetchCart(for: user)
        for item in items {
            context.delete(item)
        }
        saveContext()
    }
    
    func fetchUser(byEmail email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }
    
    // Save context safely
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("❌ Failed saving Core Data: \(error)")
        }
    }
}
