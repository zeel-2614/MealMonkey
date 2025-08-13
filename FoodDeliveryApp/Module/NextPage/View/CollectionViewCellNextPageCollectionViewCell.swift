import UIKit

class CollectionViewCellNextPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgNextPage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: Feature){
        imgNextPage.image = UIImage(named: model.imageName)
    }
}
