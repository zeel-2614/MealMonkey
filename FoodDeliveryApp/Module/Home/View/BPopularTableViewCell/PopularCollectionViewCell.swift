import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblTotalNumberRattings: UILabel!
    @IBOutlet weak var imgPopular: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: ProductModel) {
        lblProductName.text = item.strProductName
        lblRattings.text = "\(item.floatProductRating)"
        lblFoodCategory.text = "\(item.objProductType.rawValue)"
        imgPopular.image = UIImage(named: item.strProductImage)
    }
}
