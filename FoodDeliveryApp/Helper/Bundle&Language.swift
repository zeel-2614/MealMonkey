//
//  Bundle&Language.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 06/09/25.
//

import Foundation

private var bundleKey: UInt8 = 0

extension Bundle {
    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, PrivateBundle.self)
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey, language, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private class PrivateBundle: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String,
                                  value: String?,
                                  table tableName: String?) -> String {
        if let lang = objc_getAssociatedObject(self, &bundleKey) as? String,
           let path = super.path(forResource: lang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            print("🌐 Using language: \(lang)")
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            print("⚠️ Language fallback, could not find lproj for: \(String(describing: objc_getAssociatedObject(self, &bundleKey)))")
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}
