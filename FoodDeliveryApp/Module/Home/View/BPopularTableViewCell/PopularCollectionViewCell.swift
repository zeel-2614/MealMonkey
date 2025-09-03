import UIKit

// MARK: - PopularCollectionViewCell
class PopularCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblTotalNumberRattings: UILabel!
    @IBOutlet weak var imgPopular: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
}
