import UIKit

class DessertsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgDessert: UIImageView!
    @IBOutlet weak var lblDessertTitle: UILabel!
    @IBOutlet weak var imgShade: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var btnStar: UIButton!

    @IBOutlet weak var lblRestaurantName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func dessertConfigureCell(dessert: ProductModel) {
        lblDessertTitle.text = dessert.strProductName
        lblRestaurantName.text = "Meal Monkey"
        lblCategoryName.text = "\(dessert.objProductCategory)"
        lblRating.text = String(format: "%.1f", dessert.floatProductRating)
        imgDessert.image = UIImage(named: dessert.strProductImage)
        imgShade.image = UIImage(named: "ic_desserts_back_shade")
    }
    
    private func getStyledText(_ text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        if let dotRange = text.range(of: "•") {
            let nsRange = NSRange(dotRange, in: text)
            attributed.addAttribute(.foregroundColor, value: UIColor.orange, range: nsRange)
        }
        return attributed
    }
}
