//
//  CDProduct+CoreDataProperties.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 28/08/25.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var category: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var productId: Int64
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var productRating: Double
    @NSManaged public var productType: String?
    @NSManaged public var totalRating: Int32

}

extension CDProduct : Identifiable {

}
