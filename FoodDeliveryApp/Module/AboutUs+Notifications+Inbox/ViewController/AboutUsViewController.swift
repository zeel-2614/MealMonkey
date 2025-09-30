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
        applyTheme()
        
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
        reloadLocalizedData()
        applyTheme()
        
        // Reload table with themed cells
        tblMoreOpions.reloadData()
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
    
    func reloadLocalizedData() {
        // Repopulate the array based on current objPageType
        switch objPageType {
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
        default:
            arrCurrent = []
        }
        
        // Reload table view
        tblMoreOpions.reloadData()
        
        // Reset navigation title with new localized strings
        switch objPageType {
        case .Notification:
            setLeftAlignedTitleWithBack(Main.setTitle.notificationTitle, target: self, action: #selector(backButtonTapped))
        case .Inbox:
            setLeftAlignedTitleWithBack(Main.setTitle.inboxTitle, target: self, action: #selector(backButtonTapped))
        case .AboutUs:
            setLeftAlignedTitleWithBack(Main.setTitle.aboutUsTitle, target: self, action: #selector(backButtonTapped))
        default:
            break
        }
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Background
        view.backgroundColor = theme.backgroundColor
        
        // Navigation Bar
        navigationController?.navigationBar.barTintColor = theme.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.labelTextColor]
        navigationController?.navigationBar.tintColor = theme.labelTextColor
    }
}
