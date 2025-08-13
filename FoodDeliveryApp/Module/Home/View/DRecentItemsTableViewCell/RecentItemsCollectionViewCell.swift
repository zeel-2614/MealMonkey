import UIKit

class RecentItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTotalNumberOfRattings: UILabel!
    @IBOutlet weak var lblFoodType: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblFoodRatting: UILabel!
    @IBOutlet weak var imgRecentItem: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgRecentItem])
    }
    
    func configure(with item: ProductModel) {
        lblItemName.text = item.strProductName
        lblFoodType.text = item.objProductType.rawValue
        lblFoodRatting.text = "\(item.floatProductRating)"
        lblTotalNumberOfRattings.text = "\(item.intTotalNumberOfRatings)"
        imgRecentItem.image = UIImage(named: item.strProductImage)
    }
}
