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
}
