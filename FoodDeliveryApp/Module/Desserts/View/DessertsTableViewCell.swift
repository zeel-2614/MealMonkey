import UIKit

class DessertsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgDessert: UIImageView!
    @IBOutlet weak var lblDessertTitle: UILabel!
    @IBOutlet weak var imgShade: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRestaurantName: UILabel!
    
    // MARK: - Lifecycle Methods
    /// Called after the cell has been loaded from the Interface Builder.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Called to configure the cell’s selection state.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Configuration Method
    /**
     Configures the cell UI elements with the provided `ProductModel` data.
     
     - Parameter dessert: The `ProductModel` object containing dessert details.
     */
    func dessertConfigureCell(dessert: ProductModel) {
        lblDessertTitle.text = dessert.strProductName
        lblRestaurantName.text = Main.setTitle.restaurantName
        lblCategoryName.text = "\(dessert.objProductCategory)"
        lblRating.text = String(format: Main.cartAlertMessage.dessertPriceFormat, dessert.floatProductRating)
        imgDessert.image = UIImage(named: dessert.strProductImage)
        imgShade.image = UIImage(named: Main.Images.dessertsBackShade)
    }
    
    // MARK: - Helper Method
    /**
     Creates a styled attributed string where the "•" character is highlighted in orange.
     
     - Parameter text: The original string to style.
     - Returns: An `NSAttributedString` with custom styling applied to the "•" character.
     */
    private func getStyledText(_ text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        if let dotRange = text.range(of: "•") {
            let nsRange = NSRange(dotRange, in: text)
            attributed.addAttribute(.foregroundColor, value: UIColor.orange, range: nsRange)
        }
        return attributed
    }
}
