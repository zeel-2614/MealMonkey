
import Foundation

// MARK: - Model class representing a product category
class ClassCategory: NSObject {
    var strCategoryName: String = ""
    var intItems: Int = 0
    var imgCategory: String = ""
    
    /// Initializes a new category object
    /// - Parameters:
    ///   - strCategoryName: Name of the category
    ///   - intItems: Number of items in the category
    ///   - imgCategory: Name of the image asset for the category
    init(strCategoryName: String, intItems: Int, imgCategory: String) {
        self.strCategoryName = strCategoryName
        self.intItems = intItems
        self.imgCategory = imgCategory
    }
    
    /// Provides a predefined list of sample categories
    /// - Returns: Array of `ClassCategory` objects
    class func addCategory() -> [ClassCategory] {
        
        return [
            ClassCategory(strCategoryName: "Food",
                          intItems: 120,
                          imgCategory: "ic_Food"),
            ClassCategory(strCategoryName: "Beverages",
                          intItems: 220,
                          imgCategory: "ic_Beverages"),
            ClassCategory(strCategoryName: "Desserts",
                          intItems: 155,
                          imgCategory: "ic_Desserts")
        ]
    }
}
