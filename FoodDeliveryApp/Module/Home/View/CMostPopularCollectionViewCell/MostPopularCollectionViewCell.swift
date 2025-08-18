import UIKit

// MARK: - MostPopularCollectionViewCell
class MostPopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var imgMostPopular: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
}
