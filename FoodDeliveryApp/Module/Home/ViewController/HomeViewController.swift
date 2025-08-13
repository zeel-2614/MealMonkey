import UIKit

class HomeViewController: UIViewController, HomeTableViewCellDelegate, UITextFieldDelegate, MapViewControllerDelegate {
    
    func didSelectAddress(_ address: String) {
        // Remove duplicate place name at start if repeated
        var cleanedAddress = address
        if let firstComma = address.firstIndex(of: ",") {
            let firstPart = address[..<firstComma].trimmingCharacters(in: .whitespaces)
            let rest = address[address.index(after: firstComma)...].trimmingCharacters(in: .whitespaces)
            
            if rest.hasPrefix(firstPart) {
                cleanedAddress = rest // drop the duplicate
            }
        }
        
        // Now split into two lines max
        if let commaIndex = cleanedAddress.firstIndex(of: ",") {
            let firstLine = cleanedAddress[..<commaIndex].trimmingCharacters(in: .whitespaces)
            let secondLine = cleanedAddress[address.index(after: commaIndex)...].trimmingCharacters(in: .whitespaces)
            lblCurrentLocation.text = "\(firstLine)\n\(secondLine)"
        } else {
            lblCurrentLocation.text = cleanedAddress
        }
        
        lblCurrentLocation.numberOfLines = 2
        lblCurrentLocation.lineBreakMode = .byTruncatingTail
    }
    
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var selectedCategory: ProductCategory = .All
    var arrProductData: [ProductModel] = ProductModel.addProductData()
    var objProductCategory: ProductModel?
    var recentItems: [ProductModel] = []
    var filteredProductData: [ProductModel] = [] //new added
    
    override func viewWillAppear(_ animated: Bool) {
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblHome.reloadData()
        filterProducts(with: txtSearch.text) //added new
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitle("Good morning Akila!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: txtSearch.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearch])
        
        setPadding(textfield: [txtSearch])
        
        tblHome.showsVerticalScrollIndicator = false
        tblHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
        txtSearch.delegate = self //new added
        
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) //new added
        
        
        filteredProductData = arrProductData //new added
        
        DispatchQueue.main.async {
            self.tblHome.reloadData()
        }
    }
    
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
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
    
    // Use this method for real-time filtering as the user types
    @objc func textFieldDidChange(_ textField: UITextField) {
        filterProducts(with: textField.text)
    }
    
    func filterProducts(with searchText: String?) {
        if let text = searchText, !text.isEmpty {
            let lowercaseText = text.lowercased()
            filteredProductData = arrProductData.filter { product in
                // Check if the product name or the product category contains the search text
                let productNameMatches = product.strProductName.lowercased().contains(lowercaseText)
                let productCategoryMatches = product.objProductCategory.rawValue.lowercased().contains(lowercaseText)
                return productNameMatches || productCategoryMatches
            }
        } else {
            // If the search bar is empty, show all products
            filteredProductData = arrProductData
        }
        
        DispatchQueue.main.async {
            self.tblHome.reloadData()
        }
    }
}
