//
//  ValidationHelper.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 02/09/25.
//

import Foundation
struct ValidationHelper {
    
    /// Validates email format
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /// Validates password:
    /// - At least 8 characters
    /// - At least 1 uppercase
    /// - At least 1 lowercase
    /// - At least 1 number
    /// - At least 1 special character
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}
