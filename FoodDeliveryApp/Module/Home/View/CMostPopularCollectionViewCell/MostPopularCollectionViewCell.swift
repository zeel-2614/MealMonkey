import UIKit

class MostPopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var lblFoodCategory: UILabel!
    @IBOutlet weak var imgMostPopular: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgMostPopular])
    }
    
    func configure(with item: ProductModel) {
        lblFoodName.text = item.strProductName
        lblFoodCategory.text = item.objProductCategory.rawValue
        lblRattings.text = "\(item.floatProductRating)"
        imgMostPopular.image = UIImage(named: item.strProductImage)
    }
}
