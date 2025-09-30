import UIKit

/// A collection view cell that displays a feature image on the next page.
class CollectionViewCellNextPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nextpageView: UIView!
    @IBOutlet weak var imgNextPage: UIImageView!
    
    /// Called after the cell has been loaded from the nib or storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configures the cell with a `Feature` model.
    /// - Parameter model: The `Feature` instance containing image details.
    func configure(with model: Feature){
        imgNextPage.image = UIImage(named: model.imageName)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        nextpageView.backgroundColor = theme.backgroundColor
    }
}
