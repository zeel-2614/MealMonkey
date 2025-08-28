import UIKit

// MARK: - HomeCategoryCollectionViewCell
class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
            imgCategory.image = UIImage(named: "ic_all")
        case .Punjabi:
            imgCategory.image = UIImage(named: "ic_paneertikka")
        case .Chinese:
            imgCategory.image = UIImage(named: "ic_hakkanoodles")
        case .Gujarati:
            imgCategory.image = UIImage(named: "Ic_Khaman_Dhokla")
        case .SouthIndian:
            imgCategory.image = UIImage(named: "ic_masaladosa")
        case .WesternFood:
            imgCategory.image = UIImage(named: "ic_margherita_pizza")
        }
    }
}
