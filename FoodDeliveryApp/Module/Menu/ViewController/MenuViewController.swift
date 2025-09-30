import UIKit
import Lottie

// MARK: - MenuViewController
/// Displays the menu screen with a list of food categories and a search bar.
class MenuViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var tblBackView: UIView!
    
    // MARK: - Properties
    /// Array holding all menu categories
    var arrCategory: [ClassCategory] = ClassCategory.addCategory()
    var arrFilterCategory: [ClassCategory] = []
    var emptyAnimationView: LottieAnimationView!
    var emptyLabel: UILabel!
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrFilterCategory = arrCategory
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle(Main.setTitle.menuTitle)
        setCartButtonWithBadge(target: self, action: #selector(cartBtnTapped))
        
        applyCornerRadiusTLBR()
        
        tblCategory.showsVerticalScrollIndicator = false
        tblCategory.backgroundColor = .clear
        tblCategory.register(UINib(nibName: Main.CellIdentifiers.menuTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.menuTableViewCell)
        setAnimation()
        applyTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        reloadLocalizedData()
        applyTheme()
    }
    // MARK: - Actions
    /// Handles cart button tap event
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    // MARK: - UI Styling Helpers
    /// Applies top-left and bottom-right corner radius to the table background view
    func applyCornerRadiusTLBR() {
        tblBackView.layer.cornerRadius = 28
        tblBackView.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
        ]
        tblBackView.clipsToBounds = true
    }
    
    /// Adds left and right padding to a list of text fields
    /// - Parameter textfield: An array of UITextFields to add padding to
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    func setAnimation() {
        let emptyState = EmptyStateHelper.setupEmptyState(
            in: view,
            animationName: Main.Animation.menuAnimationName.0,   // name of your Lottie JSON
            message: Main.Animation.menuAnimationName.1
        )
        emptyAnimationView = emptyState.animationView
        emptyLabel = emptyState.label
        if arrFilterCategory.isEmpty {
            EmptyStateHelper.show(animationView: emptyAnimationView, label: emptyLabel)
        } else {
            EmptyStateHelper.hide(animationView: emptyAnimationView, label: emptyLabel)
        }
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2 , borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
        setPadding(textfield: [txtSearchFood])
    }
    
    func reloadLocalizedData() {
        // 1. Repopulate your categories using localized strings
        arrCategory = ClassCategory.addCategory()
        arrFilterCategory = arrCategory
        
        // 2. Reload table view
        tblCategory.reloadData()
        
        // 3. Update navigation title and other UI if needed
        setLeftAlignedTitle(Main.setTitle.menuTitle)
        
        // 4. Reapply empty state animation if necessary
        setAnimation()
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Backgrounds
        view.backgroundColor = theme.backgroundColor
        tblBackView.backgroundColor = theme.buttonColor
        tblCategory.backgroundColor = .clear
        menuView.backgroundColor = theme.backgroundColor
        
        // TextField
        txtSearchFood.backgroundColor = theme.cardCellBackgroundColor
        txtSearchFood.textColor = theme.labelTextColor
        txtSearchFood.tintColor = theme.labelTextColor
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
    }
}
