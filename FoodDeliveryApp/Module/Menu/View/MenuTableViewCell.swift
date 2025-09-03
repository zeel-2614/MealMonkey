import UIKit

// MARK: - Custom UITableViewCell for displaying a menu category
class MenuTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var lblItems: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Called after the cell's view has been loaded from the nib or storyboard
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Handles the selection state change for the cell
    }
    // MARK: - Configuration Method
    /// Configures the cell UI with a given category model
    /// - Parameter category: The `ClassCategory` object containing data
    func configureCell(category: ClassCategory) {
        imgCategory.image = UIImage(named: category.imgCategory)
        lblCategoryName.text = category.strCategoryName
        lblItems.text = "\(category.intItems) \(Main.menu.items)"
    }
}
