import UIKit

/// `OffersViewController` is responsible for displaying the latest offers in a table view.
class OffersViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnCheckOffer: UIButton!
    @IBOutlet weak var tblOffers: UITableView!
    
    /// Array of offers to be displayed, populated using `OfferModel.addOffers()`.
    var arrOffer: [OfferModel] = OfferModel.addOffers()
    
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStyle(cornerRadius: btnCheckOffer.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOffer])
        
        setLeftAlignedTitle("Latest Offers")
        setCartButtonWithBadge(target: self, action: #selector(btnCartTapped))
        
        tblOffers.showsVerticalScrollIndicator = false
        tblOffers.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
    }
    /**
     Action triggered when the cart button is tapped.
     This method navigates to the `CartViewController` in the "ProductStoryboard".
     */
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
