//
//  OrderItem+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension OrderItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItem> {
        return NSFetchRequest<OrderItem>(entityName: "OrderItem")
    }

    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var productId: Int64
    @NSManaged public var productName: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var type: String?
    @NSManaged public var user: String?
    @NSManaged public var order: Orders?
    @NSManaged public var users: User?

}

extension OrderItem : Identifiable {

}
