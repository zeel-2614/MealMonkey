import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: 10, borderWidth: 0, borderColor: .systemGray, textField: [imgCategory])
    }
    
    func configure(with category: ProductCategory) {
        lblCategory.text = category.rawValue
        
        // Provide images for categories explicitly, e.g.:
        switch category {
        case .All:
            imgCategory.image = UIImage(named: "ic_butternaan")
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
