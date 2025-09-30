import UIKit

// MARK: - HomeCategoryCollectionViewCell
class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryCollectionView: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
        // Style category image
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgCategory])
    }
    
    // MARK: - Configuration
    /// Configures the cell with the given product category.
    func configure(with category: ProductCategory) {
        lblCategory.text = category.rawValue
        
        // Assign category-specific image
        switch category {
        case .All:
            imgCategory.image = UIImage(named: Main.Images.all)
        case .Punjabi:
            imgCategory.image = UIImage(named: Main.Images.paneertikka)
        case .Chinese:
            imgCategory.image = UIImage(named: Main.Images.hakkanoodles)
        case .Gujarati:
            imgCategory.image = UIImage(named: Main.Images.khamanDhokla)
        case .SouthIndian:
            imgCategory.image = UIImage(named: Main.Images.masalaDosa)
        case .WesternFood:
            imgCategory.image = UIImage(named: Main.Images.margheritaPizza)
        }
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Cell background
        contentView.backgroundColor = theme.backgroundColor
        categoryCollectionView.backgroundColor = theme.backgroundColor
        
        // Label
        lblCategory.textColor = theme.labelTextColor
        
        // Image border (optional)
        imgCategory.layer.borderColor = theme.cardCellBorderColor.cgColor
        imgCategory.layer.borderWidth = 1
    }
}
