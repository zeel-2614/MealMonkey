import UIKit

/// Protocol defining a delegate to handle card deletion actions from a table view cell.
protocol CardDetailsCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: CardTableViewCell)
}

/// Custom table view cell representing a saved payment card.
class CardTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgCardCategory: UIImageView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var btnCardDelete: UIButton!
    
    weak var delegate: CardDetailsCellDelegate?
    
    /// Called after the cell's view has been loaded from the nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewStyle.viewStyle(cornerRadius: btnCardDelete.frame.size.height / 2, borderWidth: 1, borderColor: .buttonBackground, textField: [btnCardDelete])
    }
    
    /// Handles selection state changes for the cell.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     Action triggered when the delete button is tapped.
     - Parameter sender: The button that triggered the action.
     */
    @IBAction func btnCardDeleteClick(_ sender: Any) {
        delegate?.didTapDeleteButton(in: self)
    }
}
