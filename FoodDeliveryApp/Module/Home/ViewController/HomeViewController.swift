import UIKit

class HomeViewController: UIViewController, HomeTableViewCellDelegate {
    
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var selectedCategory: ProductCategory = .All
    var arrProductData: [ProductModel] = ProductModel.addProductData()
    var objProductCategory: ProductModel?
    var recentItems: [ProductModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        recentItems = RecentItemsHelper.shared.getRecentItems()
        tblHome.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitle("Good morning Akila!")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: txtSearch.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearch])
        
        setPadding(textfield: [txtSearch])
        
        tblHome.showsVerticalScrollIndicator = false
        tblHome.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        
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
}
