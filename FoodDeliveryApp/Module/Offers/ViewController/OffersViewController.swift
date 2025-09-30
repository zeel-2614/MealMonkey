import UIKit

/// `OffersViewController` is responsible for displaying the latest offers in a table view.
class OffersViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var btnCheckOffer: UIButton!
    @IBOutlet weak var tblOffers: UITableView!
    
    /// Array of offers to be displayed, populated using `OfferModel.addOffers()`.
    var arrOffer: [OfferModel] = OfferModel.addOffers()
    
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        viewStyle(cornerRadius: btnCheckOffer.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [btnCheckOffer])
        
        setLeftAlignedTitle(Main.setTitle.offersTitle)
        btnCheckOffer.setTitle(Main.offer.checkOffersButton, for: .normal)
        setCartButtonWithBadge(target: self, action: #selector(btnCartTapped))
        
        tblOffers.showsVerticalScrollIndicator = false
        tblOffers.register(UINib(nibName: Main.CellIdentifiers.offersTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.offersTableViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        reloadLocalizedData()
        applyTheme()
    }
    /**
     Action triggered when the cart button is tapped.
     This method navigates to the `CartViewController` in the "ProductStoryboard".
     */
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    func reloadLocalizedData() {
        // Reload localized strings
        setLeftAlignedTitle(Main.setTitle.offersTitle)
        btnCheckOffer.setTitle(Main.offer.checkOffersButton, for: .normal)
        
        // Reload table data
        arrOffer = OfferModel.addOffers()
        tblOffers.reloadData()
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Background
        view.backgroundColor = theme.backgroundColor
        offersView.backgroundColor = theme.backgroundColor
        
        // Buttons
        btnCheckOffer.backgroundColor = theme.buttonColor
        btnCheckOffer.setTitleColor(theme.buttonTextColor, for: .normal)
        
        // Table view background
        tblOffers.backgroundColor = theme.backgroundColor
    }
}
