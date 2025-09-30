import UIKit

// MARK: - RecentItemsCollectionViewCell
class RecentItemsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTotalNumberOfRattings: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblFoodRatting: UILabel!
    @IBOutlet weak var recentItemsView: UIView!
    @IBOutlet weak var imgRecentItem: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgRecentItem])
    }
    
    // MARK: - Configuration
    /// Configures the cell with the provided product model.
    func configure(with item: ProductModel) {
        lblItemName.text = item.strProductName
        lblFoodType.text = item.objProductType.rawValue
        lblFoodRatting.text = "\(item.floatProductRating)"
        lblTotalNumberOfRattings.text = "\(item.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: item.strProductImage)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Cell background
        contentView.backgroundColor = theme.backgroundColor
        recentItemsView.backgroundColor = theme.backgroundColor
        
        // Labels
        lblItemName.textColor = theme.labelTextColor
        lblFoodType.textColor = theme.labelTextColor
        lblFoodRatting.textColor = theme.labelTextColor
        lblTotalNumberOfRattings.textColor = theme.labelTextColor
        
        // Image border
        imgRecentItem.layer.borderColor = theme.cardCellBorderColor.cgColor
        imgRecentItem.layer.borderWidth = 1
    }
}
