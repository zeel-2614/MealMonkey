import UIKit

/// View controller responsible for displaying the "More" menu options.
class MoreViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblMenu: UITableView!
    
    /// Array of menu items loaded from `ClassMore.addMore()`.
    var arrMore: [ClassMore] = ClassMore.addMore()
    
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle("More")
        setCartButtonWithBadge(target: self, action: #selector(cartButtonTapped))
        tblMenu.register(UINib(nibName: "MoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTableViewCell")
    }
    
    /// Called before the view appears on screen.
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
    }
    
    /// Action triggered when the cart button is tapped.
    @objc func cartButtonTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
