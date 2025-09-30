
import Foundation

/// Model representing a "More" menu item in the app.
class ClassMore: NSObject {
    
    var strMoreName: String = ""
    var imgMenu: String = ""
    var intTag: Int = 0
    
    /// Initializes a new `ClassMore` instance.
    /// - Parameters:
    ///   - strMoreName: The title of the menu option.
    ///   - imgMenu: The image asset name.
    ///   - intTag: The unique tag identifier.
    init(strMoreName: String, imgMenu: String, intTag: Int) {
        self.strMoreName = strMoreName
        self.imgMenu = imgMenu
        self.intTag = intTag
    }
    
    /// Creates and returns a list of predefined "More" menu items.
    /// - Returns: An array of `ClassMore` objects for the More screen.
    class func addMore() -> [ClassMore] {
        return [
            ClassMore(strMoreName: Main.more.paymentDetails,
                      imgMenu: Main.Images.paymentDetails,
                      intTag: 0),
            ClassMore(strMoreName: Main.more.myOrder,
                      imgMenu: Main.Images.myOrders,
                      intTag: 1),
            ClassMore(strMoreName: Main.more.notification,
                      imgMenu: Main.Images.notification,
                      intTag: 2),
            ClassMore(strMoreName: Main.more.inbox,
                      imgMenu: Main.Images.inbox,
                      intTag: 3),
            ClassMore(strMoreName: Main.more.aboutUs,
                      imgMenu: Main.Images.aboutUs,
                      intTag: 4),
            ClassMore(strMoreName: Main.more.wishlist,
                      imgMenu: Main.Images.wishlist,
                      intTag: 5),
            ClassMore(strMoreName: Main.more.language,
                      imgMenu: Main.Images.languageImage,
                      intTag: 6),
            ClassMore(strMoreName: Main.more.theme,
                      imgMenu: Main.Images.themeImage,
                      intTag: 7)
        ]
    }
}
