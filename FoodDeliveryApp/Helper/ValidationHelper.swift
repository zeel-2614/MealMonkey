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
        let emailRegex = Main.loginAlert.emailRegex
        let emailTest = NSPredicate(format: Main.loginAlert.TestFormat, emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    /// Validates password:
    /// - At least 8 characters
    /// - At least 1 uppercase
    /// - At least 1 lowercase
    /// - At least 1 number
    /// - At least 1 special character
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = Main.loginAlert.passwordRegex
        let passwordTest = NSPredicate(format: Main.loginAlert.TestFormat, passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}
