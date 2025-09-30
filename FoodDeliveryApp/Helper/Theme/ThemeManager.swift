//
//  ThemeManager.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/09/25.
//

import Foundation
import UIKit

class ThemeManager {
    static let shared = ThemeManager()
    private init() {}

    var currentTheme: Theme = ThemeManager.redTheme {
        didSet {
            NotificationCenter.default.post(name: .themeChanged, object: nil)
        }
    }
    
    var currentThemeEnum: AppTheme = .light
    // MARK: - Theme Definitions
    static let redTheme = Theme(
        backgroundColor: .white,
        buttonColor: UIColor(hex: "#E53935"),
        buttonTextColor: .white,
        labelTextColor: UIColor(hex: "#7C7D7E"), // Example label color
        cardCellBorderColor: UIColor.lightGray, // Corrected name
        cardCellBackgroundColor: UIColor(hex: "#FFF8E1"), // Corrected name
        checkoutViewColor: UIColor(hex: "#D9D9D9"),
        foodTitleColor: UIColor.black,
        facebookButtonColor: UIColor(hex: "#367FC0"),
        googleButtonColor: UIColor(hex: "#DD4B39"),
        navigationBarColor: .white
    )

    static let greenTheme = Theme(
        backgroundColor: UIColor(hex: "#F1F8E9"),
        buttonColor: UIColor(hex: "#43A047"),
        buttonTextColor: .white,
        labelTextColor: UIColor(hex: "#1B5E20"),  // Added label text color
        cardCellBorderColor: UIColor(hex: "#A5D6A7"),
        cardCellBackgroundColor: UIColor(hex: "#C8E6C9"),
        checkoutViewColor: UIColor(hex: "#81C784"),
        foodTitleColor: UIColor(hex: "#2E7D32"),
        facebookButtonColor: UIColor(hex: "#367FC0"),
        googleButtonColor: UIColor(hex: "#DD4B39"),
        navigationBarColor: UIColor(hex: "#F1F8E9")
    )

    static let blueTheme = Theme(
        backgroundColor: UIColor(red: 0.9, green: 0.95, blue: 1, alpha: 1),
        buttonColor: .darkGray,
        buttonTextColor: .white,
        labelTextColor: .black,
        cardCellBorderColor: UIColor(hex: "#90CAF9"),
        cardCellBackgroundColor: UIColor(red: 0.8, green: 0.9, blue: 1, alpha: 1),
        checkoutViewColor: UIColor(hex: "#64B5F6"),
        foodTitleColor: UIColor(hex: "#0D47A1"),
        facebookButtonColor: UIColor(hex: "#367FC0"),
        googleButtonColor: UIColor(hex: "#DD4B39"),
        navigationBarColor: UIColor(red: 0.9, green: 0.95, blue: 1, alpha: 1)
    )

    static let darkBrownTheme = Theme(
        backgroundColor: UIColor(hex: "#FFF8E1"),
        buttonColor: UIColor(hex: "#3E2723"),
        buttonTextColor: .white,
        labelTextColor: .black,
        cardCellBorderColor: UIColor(hex: "#8D6E63"),
        cardCellBackgroundColor: UIColor(hex: "#D7CCC8"),
        checkoutViewColor: UIColor(hex: "#BCAAA4"),
        foodTitleColor: UIColor(hex: "#4E342E"),
        facebookButtonColor: UIColor(hex: "#367FC0"),
        googleButtonColor: UIColor(hex: "#DD4B39"),
        navigationBarColor: UIColor(hex: "#FFF8E1")
    )

    static let coralTheme = Theme(
        backgroundColor: UIColor(hex: "#F5F5F5"),
        buttonColor: UIColor(hex: "#212121"),
        buttonTextColor: .white,
        labelTextColor: .black,
        cardCellBorderColor: UIColor(hex: "#FFAB91"),
        cardCellBackgroundColor: UIColor(hex: "#FFE0B2"),
        checkoutViewColor: UIColor(hex: "#FFCCBC"),
        foodTitleColor: UIColor(hex: "#D84315"),
        facebookButtonColor: UIColor(hex: "#367FC0"),
        googleButtonColor: UIColor(hex: "#DD4B39"),
        navigationBarColor: UIColor(hex: "#F5F5F5")
    )
    
    static let lightTheme = Theme(
        backgroundColor: .white,
        buttonColor: UIColor(hex: "#FC6011"),
        buttonTextColor: .white,
        labelTextColor: UIColor(hex: "#7C7D7E"),
        cardCellBorderColor: UIColor(hex: "#707070"),
        cardCellBackgroundColor: UIColor(hex: "#F2F2F2"),
        checkoutViewColor: UIColor(hex: "#D9D9D9"),
        foodTitleColor: UIColor(hex: "#4A4B4D"),
        facebookButtonColor: UIColor(hex: "#367FC0"),
        googleButtonColor: UIColor(hex: "#DD4B39"),
        navigationBarColor: .white // Add this line
    )
    // MARK: - Apply Theme
    // In ThemeManager
    func applyTheme(_ theme: AppTheme) {
        currentThemeEnum = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "SelectedTheme")
        switch theme {
        case .light: currentTheme = ThemeManager.lightTheme
        case .red: currentTheme = ThemeManager.redTheme
        case .green: currentTheme = ThemeManager.greenTheme
        case .blue: currentTheme = ThemeManager.blueTheme
        case .darkBrown: currentTheme = ThemeManager.darkBrownTheme
        case .coral: currentTheme = ThemeManager.coralTheme
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension Notification.Name {
    static let themeChanged = Notification.Name("themeChanged")
}
