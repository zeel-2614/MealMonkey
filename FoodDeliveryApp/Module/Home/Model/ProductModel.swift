//
//  ProductModel.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import Foundation
import UIKit

class ProductModel: Codable {
    var intId: Int = 0
    var strProductName: String = ""
    var strProductDescription: String = ""
    var floatProductRating: Float = 0.0
    var doubleProductPrice: Double = 0.0
    var strProductImage: String = ""
    var intProductQty: Int?
    var intTotalNumberOfRatings: Int = 0
    var objProductCategory: ProductCategory = .Gujarati
    var objProductType: ProductType = .food

    init(
        intId: Int,
        strProductName: String,
        strProductDescription: String,
        floatProductRating: Float,
        doubleProductPrice: Double,
        strProductImage: String,
        intProductQty: Int? = nil,
        intTotalNumberOfRatings: Int,
        objProductCategory: ProductCategory,
        objProductType: ProductType
    ) {
        self.intId = intId
        self.strProductName = strProductName
        self.strProductDescription = strProductDescription
        self.floatProductRating = floatProductRating
        self.doubleProductPrice = doubleProductPrice
        self.strProductImage = strProductImage
        self.intProductQty = intProductQty
        self.intTotalNumberOfRatings = intTotalNumberOfRatings
        self.objProductCategory = objProductCategory
        self.objProductType = objProductType
    }

}
enum ProductType: String, Codable {
    case food
    case Beverages
    case Desserts
}

enum ProductCategory: String, CaseIterable, Codable {
    case All
    case Punjabi
    case Chinese
    case Gujarati
    case SouthIndian
    case WesternFood
}
