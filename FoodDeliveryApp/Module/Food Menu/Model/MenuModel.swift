//
//  MenuModel.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 05/08/25.
//

import Foundation
class MenuModel: NSObject {
    var strImage: String
    var strTitle: String
    var strItem: String
    
    init(strImage: String, strTitle: String, strItem: String) {
        self.strImage = strImage
        self.strTitle = strTitle
        self.strItem = strItem
    }
    
    class func getMenuData() -> [MenuModel] {
        return [
            MenuModel(strImage: "ic_FoodImage",
                      strTitle: "Food",
                      strItem: "120 Items"),
            MenuModel(strImage: "ic_BevaragesImage",
                      strTitle: "Bevarages",
                      strItem: "220 Items"),
            MenuModel(strImage: "ic_DessertsImage",
                      strTitle: "Desserts",
                      strItem: "155 Items"),
            MenuModel(strImage: "ic_abc",
                      strTitle: "Promotions",
                      strItem: "25 Items"),
        ]
    }
}
