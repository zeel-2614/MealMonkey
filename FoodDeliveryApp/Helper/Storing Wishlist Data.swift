//
//  Storing Wishlist Data.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 16/08/25.
//

import Foundation

func saveWishlist(_ wishlist: [ProductModel]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(wishlist) {
        UserDefaults.standard.set(encoded, forKey: "wishlist")
        UserDefaults.standard.synchronize()
    }
}

func loadWishlist() -> [ProductModel] {
    let decoder = JSONDecoder()
    if let data = UserDefaults.standard.data(forKey: "wishlist"),
       let wishlist = try? decoder.decode([ProductModel].self, from: data) {
        return wishlist
    }
    return []
}
