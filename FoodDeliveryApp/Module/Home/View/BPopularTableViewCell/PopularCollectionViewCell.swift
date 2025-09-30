import UIKit

// MARK: - PopularCollectionViewCell
class PopularCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblTotalNumberRattings: UILabel!
    @IBOutlet weak var imgPopular: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }
    // MARK: - Configuration
    /// Configures the cell with the given product item.
    func configure(with item: ProductModel) {
        lblProductName.text = item.strProductName
        lblRattings.text = "\(item.floatProductRating)"
        lblTotalNumberRattings.text = "(\(item.intTotalNumberOfRatings) \(Main.offer.ratings))"
        lblFoodCategory.text = "\(item.objProductType.rawValue)"
        imgPopular.image = UIImage(named: item.strProductImage)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Cell background
        contentView.backgroundColor = theme.backgroundColor
        popularView.backgroundColor = theme.backgroundColor
        
        // Labels
        lblProductName.textColor = theme.labelTextColor
        lblFoodCategory.textColor = theme.labelTextColor
        lblRattings.textColor = theme.labelTextColor
        lblTotalNumberRattings.textColor = theme.labelTextColor
        
        // Image border (optional)
        imgPopular.layer.borderColor = theme.cardCellBorderColor.cgColor
        imgPopular.layer.borderWidth = 1
    }
}
