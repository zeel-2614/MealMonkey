//
//  Session Manager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 19/08/25.
//

import Foundation
class SessionManager {
    private static let userEmailKey = "loggedInUserEmail"
    
    static func save(email: String) {
        UserDefaults.standard.set(email, forKey: userEmailKey)
    }
    
    static func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: userEmailKey)
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: userEmailKey)
    }
}
