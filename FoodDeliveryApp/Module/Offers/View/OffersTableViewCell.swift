import UIKit

/// `OffersTableViewCell` is a custom table view cell that displays an offer's details.
class OffersTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblOfferTitle: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRater: UILabel!
    @IBOutlet weak var lblCafe: UILabel!
    @IBOutlet weak var lblFoodVariety: UILabel!
    
    /// Called after the view has been loaded from the nib.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Configures the selected state of the cell.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     Action triggered when the star button is clicked.
     - Parameter sender: The object that triggered the action.
     */
    @IBAction func btnStarClick(_ sender: Any) {
    }
    
    /**
     Configures the cell with the given `OfferModel`.
     - Parameter offer: An instance of `OfferModel` containing the offer's details.
     */
    func offerConfigureCell(offer: OfferModel) {
        imgOffer.image = UIImage(named: offer.imgOffer ?? "")
        lblOfferTitle.text = offer.strOfferTitle
        lblRating.text = "\(offer.intRating ?? 0.0)"
        lblRater.text = "(\(offer.intRater ?? 0) ratings)"
        lblCafe.text = offer.strCafeName
        lblFoodVariety.text = offer.strFoodVariety
    }
}
