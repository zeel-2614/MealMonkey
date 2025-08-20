//
//  Orders+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 20/08/25.
//
//

import Foundation
import CoreData


extension Orders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Orders> {
        return NSFetchRequest<Orders>(entityName: "Orders")
    }

    @NSManaged public var orderNumber: String?
    @NSManaged public var productName: String?
    @NSManaged public var productImage: String?
    @NSManaged public var totalPrice: Double
    @NSManaged public var userEmail: String?
    @NSManaged public var date: Date?
    @NSManaged public var users: User?

}

extension Orders : Identifiable {

}
