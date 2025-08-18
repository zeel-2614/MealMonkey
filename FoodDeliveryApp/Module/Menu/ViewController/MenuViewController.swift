import UIKit

// MARK: - MenuViewController
/// Displays the menu screen with a list of food categories and a search bar.
class MenuViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtSearchFood: UITextField!
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var tblBackView: UIView!
    
    // MARK: - Properties
    /// Array holding all menu categories
    var arrCategory: [ClassCategory] = ClassCategory.addCategory()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitle("Menu")
        setCartButton(target: self, action: #selector(cartBtnTapped))
        
        applyCornerRadiusTLBR()
        
        viewStyle(cornerRadius: txtSearchFood.frame.size.height/2 , borderWidth: 0, borderColor: .systemGray, textField: [txtSearchFood])
        setPadding(textfield: [txtSearchFood])
        
        tblCategory.showsVerticalScrollIndicator = false
        tblCategory.backgroundColor = .clear
        tblCategory.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    // MARK: - Actions
    /// Handles cart button tap event
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
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
}
