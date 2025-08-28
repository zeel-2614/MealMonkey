//
//  CardDetails+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension CardDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardDetails> {
        return NSFetchRequest<CardDetails>(entityName: "CardDetails")
    }

    @NSManaged public var user: User?

}

extension CardDetails : Identifiable {

}
