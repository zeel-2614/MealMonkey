//
//  User+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 20/08/25.
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
    @NSManaged public var cartItems: NSSet?
    @NSManaged public var orders: Orders?

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

extension User : Identifiable {

}
