//
//  Session Manager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 19/08/25.
//

import Foundation

/**
 `SessionManager` is a utility class responsible for managing the logged-in user's session.
 
 It provides simple methods to:
 - Save the logged-in user's email.
 - Retrieve the saved email.
 - Clear the session when the user logs out.
 
 The session data is stored securely in `UserDefaults`.
 */
class SessionManager {
    
    /// Key used to store and retrieve the logged-in user's email in `UserDefaults`.
    private static let userEmailKey = Main.Key.loggedInUserEmailKey
    
    /**
     Saves the user's email in `UserDefaults`.
     
     - Parameter email: The email address of the logged-in user.
     
     - Example:
       ```swift
       SessionManager.save(email: "user@example.com")
       ```
     */
    static func save(email: String) {
        UserDefaults.standard.set(email, forKey: userEmailKey)
    }
    
    /**
     Retrieves the logged-in user's email from `UserDefaults`.
     
     - Returns: An optional `String` containing the saved email if it exists, otherwise `nil`.
     
     - Example:
       ```swift
       if let email = SessionManager.getEmail() {
           print("Logged in as: \(email)")
       }
       ```
     */
    static func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: userEmailKey)
    }
    
    /**
     Clears the saved session data by removing the stored email from `UserDefaults`.
     
     - Example:
       ```swift
       SessionManager.clear()
       ```
     */
    static func clear() {
        UserDefaults.standard.removeObject(forKey: userEmailKey)
    }
}
