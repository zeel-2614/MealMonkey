//
//  Theme Model.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/09/25.
//

import Foundation
import UIKit

struct Theme {
    var backgroundColor: UIColor
    var buttonColor: UIColor
    var buttonTextColor: UIColor
    var labelTextColor: UIColor
    var cardCellBorderColor: UIColor
    var cardCellBackgroundColor: UIColor
    var checkoutViewColor: UIColor
    var foodTitleColor: UIColor
    var facebookButtonColor: UIColor
    var googleButtonColor: UIColor
    var navigationBarColor: UIColor
}

enum AppTheme: String, CaseIterable {
    case light
    case red
    case green
    case blue
    case darkBrown
    case coral
}
