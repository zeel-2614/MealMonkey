import UIKit

class DessertsViewController: UIViewController {
    
    @IBOutlet weak var txtSearchDesserts: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    var selectedProductType: ProductType = .Desserts
    
    var arrProductData:[ProductModel] = ProductModel.addProductData()
    var arrProducts: [ProductModel] {
        switch selectedProductType {
        case .food:
            return arrProductData.filter { $0.objProductType == .food }
        case .Desserts:
            return arrProductData.filter { $0.objProductType == .Desserts }
        case .Beverages:
            return arrProductData.filter { $0.objProductType == .Beverages }
        }
    }
    
    // Search filtered list
    var filteredProducts: [ProductModel] = []
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchDesserts])
        
        setPadding(textfield: [txtSearchDesserts])
        
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.showsVerticalScrollIndicator = false
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
        
        // Default table data is unfiltered
        filteredProducts = arrProducts
        
        switch selectedProductType {
        case .food:
            setLeftAlignedTitleWithBack(
                "Food",
                target: self,
                action: #selector(dessertBackBtn)
            )
            
        case .Beverages:
            setLeftAlignedTitleWithBack(
                "Beverages",
                target: self,
                action: #selector(dessertBackBtn)
            )
            
        case .Desserts:
            setLeftAlignedTitleWithBack(
                "Desserts",
                target: self,
                action: #selector(dessertBackBtn)
            )
        }
        
        txtSearchDesserts.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
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
    
    @objc func dessertBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
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
