import UIKit

// Main Home screen controller handling categories, products, recent items, and search functionality
class HomeViewController: UIViewController, HomeTableViewCellDelegate, UITextFieldDelegate, ChangeAddressDelegate {
    func didSelectAddress(_ address: String) {
        lblCurrentLocation.text = address
    }
    // MARK: - Outlets
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    // MARK: - Variables
    var selectedCategory: ProductCategory = .All
    static var arrProductData: [ProductModel] = []//API
    var objProductCategory: ProductModel?
    var recentItems: [ProductModel] = []
    var filteredProductData: [ProductModel] = [] //new added
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        // Load saved address from UserDefaults
        if let savedAddress = UserDefaults.standard.string(forKey: "currentAddress") {
            lblCurrentLocation.text = savedAddress
        }
        // Load recent items and reload the table
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblHome.reloadData()
        
        // Apply search filter if there’s existing text
        filterProducts(with: txtSearch.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.post(name: NSNotification.Name("ProductsLoaded"), object: nil)
        
        // Set navigation bar title and cart button
        setLeftAlignedTitle("Good morning Akila!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: txtSearch.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearch])
        setPadding(textfield: [txtSearch])
        
        // TableView setup
        tblHome.showsVerticalScrollIndicator = false
        tblHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        // Search text field delegate and change listener
        txtSearch.delegate = self //new added
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) //new added
        
        // Initially show all products
        filteredProductData = HomeViewController.arrProductData //new added
        
        fetchProductDataFromAPI()
        
        // Reload the table after UI setup
        DispatchQueue.main.async {
            self.tblHome.reloadData()
        }
    }
    
    private func fetchProductDataFromAPI() {
           // 🚨 IMPORTANT: Replace "YOUR_API_ENDPOINT_URL_HERE" with your actual URL.
           let apiURLString = "https://mocki.io/v1/a2248104-c72d-4088-bd15-c34986dc071b"
           
           APICalls.getData(from: apiURLString) { [weak self] (products: [ProductModel]) in
               guard let self = self else { return }
               
               // This closure runs on a background thread. All UI updates must be on the main thread.
               DispatchQueue.main.async {
                   if !products.isEmpty {
                       HomeViewController.arrProductData = products
                       self.filterProducts(with: self.txtSearch.text)
                   } else {
                       // Handle case where products array is empty (e.g., failed to fetch or decode)
                       print("Could not fetch products or received an empty list.")
                       // You might want to show an alert to the user here.
                       let alert = UIAlertController(title: "Error", message: "Failed to load products. Please try again.", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
                   self.tblHome.reloadData()
                   print("Data is comming form api")
               }
           }
       }
    
    // MARK: - Helper Methods
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    // MARK: - Actions
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // MARK: - HomeTableViewCellDelegate methods
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel) {
        RecentItemsHelper.shared.addProduct(product)
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.selectedProduct = product
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblHome.reloadData()
    }
    
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory) {
        selectedCategory = category
        tblHome.reloadData()
    }
    
    // MARK: - Search Handling
    // Use this method for real-time filtering as the user types
    @objc func textFieldDidChange(_ textField: UITextField) {
        filterProducts(with: textField.text)
    }
    
    func filterProducts(with searchText: String?) {
        if let text = searchText, !text.isEmpty {
            let lowercaseText = text.lowercased()
            filteredProductData = HomeViewController.arrProductData.filter { product in
                // Check if the product name or the product category contains the search text
                let productNameMatches = product.strProductName.lowercased().contains(lowercaseText)
                let productCategoryMatches = product.objProductCategory.rawValue.lowercased().contains(lowercaseText)
                return productNameMatches || productCategoryMatches
            }
        } else {
            // If the search bar is empty, show all products
            filteredProductData = HomeViewController.arrProductData
        }
        
        DispatchQueue.main.async {
            self.tblHome.reloadData()
        }
    }
}
