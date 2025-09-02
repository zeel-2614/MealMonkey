//
//  ViewStyle.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 02/09/25.
//

import Foundation
import UIKit

/// A utility class for applying consistent view styling, such as corner radius, border width, and border color.
class viewStyle {
    
    /// Applies styling to multiple `UIView` instances at once.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius to apply to the views.
    ///   - borderWidth: The width of the border.
    ///   - borderColor: The color of the border.
    ///   - textField: An array of `UIView` elements (e.g., text fields, buttons, views) to style.
    class func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, textField: [UIView]) {
        
        for item in textField {
            item.layer.cornerRadius = cornerRadius
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
}

extension UIViewController {
    
    /// Applies styling to multiple `UIView` instances within a view controller.
    ///
    /// - Parameters:
    ///   - cornerRadius: The corner radius to apply to the views.
    ///   - borderWidth: The width of the border.
    ///   - borderColor: The color of the border.
    ///   - textField: An array of `UIView` elements to style.
    func viewStyle(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, textField: [UIView]) {
        
        for item in textField {
            item.layer.cornerRadius = cornerRadius
            item.layer.borderWidth = borderWidth
            item.layer.borderColor = borderColor.cgColor
        }
    }
}

extension UITextField {
    
    /// Adds left and/or right padding inside a `UITextField`.
    ///
    /// - Parameters:
    ///   - left: The padding width on the left side. Defaults to `0`.
    ///   - right: The padding width on the right side. Defaults to `0`.
    ///
    /// - Note: This is implemented by setting `leftView` and/or `rightView` properties.
    func setPadding(left: CGFloat = 0, right: CGFloat = 0) {
        
        if left > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if right > 0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
