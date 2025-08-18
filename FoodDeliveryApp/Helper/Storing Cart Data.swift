//
//  Storing Cart Data.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 13/08/25.
//

import Foundation

/// Saves the cart data to `UserDefaults`.
///
/// - Parameter cartArray: An array of dictionaries, where each dictionary represents a product in the cart.
func saveCartToUserDefaults(cartArray: [[String: Any]]) {
    UserDefaults.standard.set(cartArray, forKey: "SavedCart")
}

/// Loads the cart data from `UserDefaults`.
///
/// - Returns: An array of product dictionaries stored in `UserDefaults` under the key `"SavedCart"`.
func loadCartFromUserDefaults() -> [[String: Any]] {
    return UserDefaults.standard.array(forKey: "SavedCart") as? [[String: Any]] ?? []
}

/// Converts a `ProductModel` into a dictionary representation for storage.
///
/// - Parameter product: The `ProductModel` to convert.
/// - Returns: A dictionary containing the product's properties.
func productToDict(_ product: ProductModel) -> [String: Any] {
    return [
        "intId": product.intId,
        "strProductName": product.strProductName,
        "strProductImage": product.strProductImage,
        "strProductDescription": product.strProductDescription,
        "doubleProductPrice": product.doubleProductPrice,
        "floatProductRating": product.floatProductRating,
        "intTotalNumberOfRatings": product.intTotalNumberOfRatings,
        "objProductType": product.objProductType.rawValue,
        "objProductCategory": product.objProductCategory.rawValue,
        "intProductQty": product.intProductQty ?? 1
    ]
}

/// Converts a dictionary into a `ProductModel`.
///
/// - Parameter dict: The dictionary containing product details.
/// - Returns: A `ProductModel` created from the dictionary's values.
func dictToProduct(_ dict: [String: Any]) -> ProductModel {
    return ProductModel(
        intId: dict["intId"] as? Int ?? 0,
        strProductName: dict["strProductName"] as? String ?? "",
        strProductDescription: dict["strProductDescription"] as? String ?? "",
        floatProductRating: Float(dict["floatProductRating"] as? Double ?? 0.0),
        doubleProductPrice: dict["doubleProductPrice"] as? Double ?? 0.0,
        strProductImage: dict["strProductImage"] as? String ?? "",
        intProductQty: dict["intProductQty"] as? Int,
        intTotalNumberOfRatings: dict["intTotalNumberOfRatings"] as? Int ?? 0,
        objProductCategory: ProductCategory(rawValue: dict["objProductCategory"] as? String ?? "") ?? .Gujarati,
        objProductType: ProductType(rawValue: dict["objProductType"] as? String ?? "") ?? .food
    )
}

/// Saves orders to `UserDefaults`.
///
/// - Parameter orders: A two-dimensional array where each inner array represents a list of products in an order.
func saveOrdersToUserDefaults(_ orders: [[ProductModel]]) {
    let ordersArray = orders.map { order in
        order.map { product in
            productToDict(product)
        }
    }
    UserDefaults.standard.set(ordersArray, forKey: "orders")
}

/// Loads orders from `UserDefaults`.
///
/// - Returns: A two-dimensional array of `ProductModel` objects representing saved orders.
func loadOrdersFromUserDefaults() -> [[ProductModel]] {
    guard let savedOrders = UserDefaults.standard.array(forKey: "orders") as? [[[String: Any]]] else {
        return []
    }
    return savedOrders.map { orderDictArray in
        orderDictArray.map { dictToProduct($0) }
    }
}
