//
//  Wishlist+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension Wishlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wishlist> {
        return NSFetchRequest<Wishlist>(entityName: "Wishlist")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var productName: String?
    @NSManaged public var type: String?
    @NSManaged public var user: User?

}

extension Wishlist : Identifiable {

}
