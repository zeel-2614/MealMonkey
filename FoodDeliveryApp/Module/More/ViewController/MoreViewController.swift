import UIKit

/// View controller responsible for displaying the "More" menu options.
class MoreViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var tblMenu: UITableView!
    
    /// Array of menu items loaded from `ClassMore.addMore()`.
    var arrMore: [ClassMore] = ClassMore.addMore()
    
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle(Main.setTitle.moreTitle)
        setCartButtonWithBadge(target: self, action: #selector(cartButtonTapped))
        tblMenu.register(UINib(nibName: Main.CellIdentifiers.moreTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.moreTableViewCell)
        applyTheme()
    }
    
    /// Called before the view appears on screen.
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        reloadLocalizedData()
        applyTheme()
    }
    
    /// Action triggered when the cart button is tapped.
    @objc func cartButtonTapped() {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    func reloadLocalizedData() {
        // Rebuild menu items with updated localized strings
        arrMore = ClassMore.addMore()
        
        // Update navigation title
        setLeftAlignedTitle(Main.setTitle.moreTitle)
        
        // Reload table
        tblMenu.reloadData()
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Background
        view.backgroundColor = theme.backgroundColor
        tblMenu.backgroundColor = theme.backgroundColor
        tblMenu.reloadData()  // Update table cells if needed
        moreView.backgroundColor = theme.backgroundColor
    }
}
