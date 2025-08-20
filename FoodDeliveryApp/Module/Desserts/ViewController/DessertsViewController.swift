import UIKit

class DessertsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtSearchDesserts: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    // MARK: - Properties
    /// Currently selected product type (e.g., Desserts, Food, Beverages).
    var selectedProductType: ProductType = .Desserts
    
    /// Master product data array loaded from `ProductModel`.
    var arrProducts: [ProductModel] {
        return HomeViewController.arrProductData.filter { $0.objProductType == selectedProductType }
    }
    
    /// Computed property returning products filtered by `selectedProductType`.
//    var arrProducts: [ProductModel] {
//        switch selectedProductType {
//        case .food:
//            return arrProductData.filter { $0.objProductType == .food }
//        case .Desserts:
//            return arrProductData.filter { $0.objProductType == .Desserts }
//        case .Beverages:
//            return arrProductData.filter { $0.objProductType == .Beverages }
//        }
//    }
    
    /// Products filtered by the search text.
    var filteredProducts: [ProductModel] = []
    var isSearching: Bool = false
    
    // MARK: - Lifecycle Methods
    /// Called after the controller’s view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(productsLoaded), name: NSNotification.Name("ProductsLoaded"), object: nil)
        
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchDesserts])
        
        setPadding(textfield: [txtSearchDesserts])
        
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.showsVerticalScrollIndicator = false
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
        filteredProducts = arrProducts
        
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack("Food", target: self, action: #selector(dessertBackBtn))
            
        case .Beverages:
            setLeftAlignedTitleWithBack("Beverages", target: self, action: #selector(dessertBackBtn))
            
        case .Desserts:
            setLeftAlignedTitleWithBack("Desserts", target: self, action: #selector(dessertBackBtn))
        }
        // Listen for search text changes.
        txtSearchDesserts.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
    @objc func productsLoaded() {
        filteredProducts = arrProducts
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
        
        tblDesserts.reloadData()
    }
    
    // MARK: - Navigation
    /// Navigates back to the previous screen.
    @objc func dessertBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Navigates to the cart view controller.
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}
