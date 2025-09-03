import UIKit

/// A custom table view cell that displays product details in the cart.
class CartTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    /// Closure that gets executed when the delete button is tapped.
    var onDelete: (() -> Void)?
    
    /// Called after the cell is loaded from the nib or storyboard.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Sets the selected state for the cell.
    /// - Parameters:
    ///   - selected: A Boolean value indicating whether the cell is selected.
    ///   - animated: A Boolean value indicating whether the change is animated.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Action triggered when the delete button is tapped.
    /// - Parameter sender: The object that initiated the action.
    //    @IBAction func btnDeleteClick(_ sender: Any) {
    //        onDelete?()
    //    }
    @IBAction func btnDeleteClick(_ sender: Any) {
        onDelete?()
    }
    
    /// Configures the cell with the given product details.
    /// - Parameter product: The product model containing the details to display.x
    func configure(with cartItem: CartItems) {
        lblProductTitle.text = cartItem.productName
        imgProduct.image = UIImage(named: cartItem.image ?? "")
        lblPrice.text = "\(Main.cartAlertMessage.priceSymbol)\(String(format: Main.cartAlertMessage.priceFormat, cartItem.price))"
        lblType.text = cartItem.type ?? ""
        lblCategory.text = cartItem.category ?? ""
        lblQty.text = "\(Main.cartAlertMessage.quantity) \(cartItem.quantity)"
    }
}
