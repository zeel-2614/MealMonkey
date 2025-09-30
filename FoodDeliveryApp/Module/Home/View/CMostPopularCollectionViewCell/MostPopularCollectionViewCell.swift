import UIKit

// MARK: - MostPopularCollectionViewCell
class MostPopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var mostPopularView: UIView!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var imgMostPopular: UIImageView!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgMostPopular])
    }
    // MARK: - Configuration
    /// Configures the cell with a given product.
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodCategory.text = item.objProductCategory.rawValue
        lblRattings.text = "\(item.floatProductRating)"
        imgMostPopular.image = UIImage(named: item.strProductImage)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Cell background
        contentView.backgroundColor = theme.backgroundColor
        mostPopularView.backgroundColor = theme.backgroundColor
        
        // Labels
        lblFoodName.textColor = theme.labelTextColor
        lblFoodCategory.textColor = theme.labelTextColor
        lblRattings.textColor = theme.labelTextColor
        
        // Image border
        imgMostPopular.layer.borderColor = theme.cardCellBorderColor.cgColor
        imgMostPopular.layer.borderWidth = 1
    }

}
