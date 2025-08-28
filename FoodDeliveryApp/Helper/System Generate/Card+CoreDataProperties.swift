//
//  Card+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var expiryMonth: String?
    @NSManaged public var expiryYear: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var number: String?
    @NSManaged public var securityCode: String?
    @NSManaged public var user: User?

}

extension Card : Identifiable {

}
