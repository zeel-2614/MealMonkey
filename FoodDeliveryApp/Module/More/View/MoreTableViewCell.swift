import UIKit

/// Custom table view cell used to display an item in the "More" menu.
class MoreTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    /// Called after the cell is loaded from the nib or storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Round the menu image into a circle.
        imgMenu.layer.cornerRadius = 28
        
        // Slight rounding for the main container view.
        viewMain.layer.cornerRadius = 7
    }
    
    /// Updates the cell’s selection state.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configures the cell with data from a `ClassMore` model.
    /// - Parameter more: The `ClassMore` instance containing menu details.
    func configureMenuCell(more: ClassMore){
        imgMenu.image = UIImage(named: more.imgMenu)
        lblMenu.text = more.strMoreName
    }
}
