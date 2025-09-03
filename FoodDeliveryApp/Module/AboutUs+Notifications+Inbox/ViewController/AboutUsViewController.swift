import UIKit

class AboutUsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblMoreOpions: UITableView!
    
    // MARK: - Properties
    var arrCurrent: [AboutModel] = []
    var objPageType: PageType = .AboutUs
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        /// Configures the current page based on `objPageType`.
        switch objPageType {
            
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
            setLeftAlignedTitleWithBack(Main.setTitle.notificationTitle, target: self, action: #selector(backButtonTapped))
            setCartButtonWithBadge(target: self, action: #selector(cartTapped))
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
            setLeftAlignedTitleWithBack(Main.setTitle.inboxTitle, target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartTapped))
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
            setLeftAlignedTitleWithBack(Main.setTitle.aboutUsTitle, target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartTapped))
            
        default:
            break
        }
        /// Registers the table view cell for reuse.
        tblMoreOpions.register(UINib(nibName: Main.CellIdentifiers.aboutUsTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.aboutUsTableViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
    }
    // MARK: - Actions
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func cartTapped() {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
