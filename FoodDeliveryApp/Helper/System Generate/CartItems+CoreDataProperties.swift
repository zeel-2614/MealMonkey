//
//  CartItems+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 18/08/25.
//
//

import Foundation
import CoreData


extension CartItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItems> {
        return NSFetchRequest<CartItems>(entityName: "CartItems")
    }

    @NSManaged public var productId: Int64
    @NSManaged public var productName: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int16
    @NSManaged public var image: String?
    @NSManaged public var user: User?

}

extension CartItems : Identifiable {

}
