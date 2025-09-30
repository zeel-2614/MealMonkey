import UIKit
import Lottie

class DessertsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dessertsView: UIView!
    @IBOutlet weak var txtSearchDesserts: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    // MARK: - Properties
    /// Currently selected product type (e.g., Desserts, Food, Beverages).
    var selectedProductType: ProductType = .Desserts
    var emptyAnimationView: LottieAnimationView!
    var emptyLabel: UILabel!
    
    /// Master product data array loaded from `ProductModel`.
    var arrProducts: [ProductModel] {
        return HomeViewController.arrProductData.filter { $0.objProductType == selectedProductType }
    }
    
    /// Products filtered by the search text.
    var filteredProducts: [ProductModel] = []
    var isSearching: Bool = false
    
    // MARK: - Lifecycle Methods
    /// Called after the controller’s view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        NotificationCenter.default.addObserver(self, selector: #selector(productsLoaded), name: NSNotification.Name(Main.Key.productsLoadedKey), object: nil)
        
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchDesserts])
        
        setPadding(textfield: [txtSearchDesserts])
        
        setCartButtonWithBadge(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.showsVerticalScrollIndicator = false
        tblDesserts.register(UINib(nibName: Main.CellIdentifiers.dessertsTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.dessertsTableViewCell)
        filteredProducts = arrProducts
        
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(Main.setTitle.foodTitle, target: self, action: #selector(dessertBackBtn))
            
        case .Beverages:
            setLeftAlignedTitleWithBack(Main.setTitle.beveragesTitle, target: self, action: #selector(dessertBackBtn))
            
        case .Desserts:
            setLeftAlignedTitleWithBack(Main.setTitle.dessertsTitle, target: self, action: #selector(dessertBackBtn))
        }
        // Listen for search text changes.
        txtSearchDesserts.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        let emptyState = EmptyStateHelper.setupEmptyState(
            in: view,
            animationName: Main.Animation.dessertsAnimationName.0,   // name of your Lottie JSON
            message: Main.Animation.dessertsAnimationName.1
        )
        emptyAnimationView = emptyState.animationView
        emptyLabel = emptyState.label
        if filteredProducts.isEmpty {
            EmptyStateHelper.show(animationView: emptyAnimationView, label: emptyLabel)
        } else {
            EmptyStateHelper.hide(animationView: emptyAnimationView, label: emptyLabel)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        reloadLocalizedData()
        applyTheme()
    }
    
    @objc func productsLoaded() {
        filteredProducts = arrProducts
        tblDesserts.reloadData()
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Main view
        view.backgroundColor = theme.backgroundColor
        dessertsView.backgroundColor = theme.backgroundColor
        
        // Search text field
        txtSearchDesserts.backgroundColor = theme.cardCellBackgroundColor
        txtSearchDesserts.textColor = theme.labelTextColor
        txtSearchDesserts.tintColor = theme.labelTextColor
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2, borderWidth: 0, borderColor: theme.cardCellBorderColor, textField: [txtSearchDesserts])
        
        // TableView
        tblDesserts.backgroundColor = theme.backgroundColor
        tblDesserts.separatorColor = theme.cardCellBorderColor
        
        tblDesserts.reloadData()
    }
    // MARK: - Search Handling
    /**
     Triggered when the search text changes.
     
     - Parameter textField: The text field whose content has changed.
     */
    @objc func searchTextChanged(_ textField: UITextField) {
        let searchText = textField.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            isSearching = false
            filteredProducts = arrProducts
        } else {
            isSearching = true
            filteredProducts = arrProducts.filter {
                $0.strProductName.lowercased().contains(searchText) ||
                $0.strProductDescription.lowercased().contains(searchText)
            }
        }
        
        if filteredProducts.isEmpty {
            EmptyStateHelper.show(animationView: emptyAnimationView, label: emptyLabel)
        } else {
            EmptyStateHelper.hide(animationView: emptyAnimationView, label: emptyLabel)
        }
        
        tblDesserts.reloadData()
    }
    
    // MARK: - Navigation
    /// Navigates back to the previous screen.
    @objc func dessertBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Navigates to the cart view controller.
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    func reloadLocalizedData() {
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(Main.setTitle.foodTitle, target: self, action: #selector(dessertBackBtn))
            
        case .Beverages:
            setLeftAlignedTitleWithBack(Main.setTitle.beveragesTitle, target: self, action: #selector(dessertBackBtn))
            
        case .Desserts:
            setLeftAlignedTitleWithBack(Main.setTitle.dessertsTitle, target: self, action: #selector(dessertBackBtn))
        }
    }
}
