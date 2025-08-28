//
//  User+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var card: CardDetails?
    @NSManaged public var cards: NSSet?
    @NSManaged public var cartItems: NSSet?
    @NSManaged public var orders: Orders?
    @NSManaged public var wishlist: NSSet?
    @NSManaged public var orderItem: OrderItem?

}

// MARK: Generated accessors for cards
extension User {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}

// MARK: Generated accessors for cartItems
extension User {

    @objc(addCartItemsObject:)
    @NSManaged public func addToCartItems(_ value: CartItems)

    @objc(removeCartItemsObject:)
    @NSManaged public func removeFromCartItems(_ value: CartItems)

    @objc(addCartItems:)
    @NSManaged public func addToCartItems(_ values: NSSet)

    @objc(removeCartItems:)
    @NSManaged public func removeFromCartItems(_ values: NSSet)

}

// MARK: Generated accessors for wishlist
extension User {

    @objc(addWishlistObject:)
    @NSManaged public func addToWishlist(_ value: Wishlist)

    @objc(removeWishlistObject:)
    @NSManaged public func removeFromWishlist(_ value: Wishlist)

    @objc(addWishlist:)
    @NSManaged public func addToWishlist(_ values: NSSet)

    @objc(removeWishlist:)
    @NSManaged public func removeFromWishlist(_ values: NSSet)

}

extension User : Identifiable {

}
