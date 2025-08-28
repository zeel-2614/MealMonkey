//
//  Orders+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension Orders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Orders> {
        return NSFetchRequest<Orders>(entityName: "Orders")
    }

    @NSManaged public var date: Date?
    @NSManaged public var orderNumber: String?
    @NSManaged public var productImage: String?
    @NSManaged public var productName: String?
    @NSManaged public var totalPrice: Double
    @NSManaged public var products: Data?
    @NSManaged public var userEmail: String?
    @NSManaged public var item: NSSet?
    @NSManaged public var items: NSSet?
    @NSManaged public var users: User?

}

// MARK: Generated accessors for item
extension Orders {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: OrderItem)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: OrderItem)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}

// MARK: Generated accessors for items
extension Orders {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CartItems)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CartItems)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Orders : Identifiable {

}
