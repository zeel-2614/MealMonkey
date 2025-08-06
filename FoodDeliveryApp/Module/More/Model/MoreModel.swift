//
//  MoreModel.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import Foundation

class MoreModel: NSObject {
    var strImage: String
    var strTitle: String
    
    init(strImage: String, strTitle: String) {
        self.strImage = strImage
        self.strTitle = strTitle
    }
    
    class func getMoreData() -> [MoreModel] {
        return [
            MoreModel(strImage: "ic_Payment",
                      strTitle: "Payment Details"),
            MoreModel(strImage: "ic_Orders",
                      strTitle: "My Orders"),
            MoreModel(strImage: "ic_Notifications",
                      strTitle: "Notifications"),
            MoreModel(strImage: "ic_Inbox",
                      strTitle: "Inbox"),
            MoreModel(strImage: "ic_AboutUs",
                      strTitle: "About Us"),
        ]
    }
}
