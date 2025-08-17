import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        let imgPicker = UITapGestureRecognizer(target: self, action: #selector(imgTap))
        imgProfile.addGestureRecognizer(imgPicker)
        
        viewStyle(cornerRadius: imgProfile.frame.size.width/2, borderWidth: 0, borderColor: .systemGray, textField: [imgProfile])
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtAddress, txtMobileNo, btnSave])
        setPadding(textfield: [txtName, txtEmail, txtAddress, txtMobileNo])
        
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(btnCartTapped))
    }
    
    // Navigate to cart screen when cart button is tapped
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // Trigger image picker when profile image is tapped
    @objc func imgTap() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    // Sign out and navigate to login screen
    @IBAction func btnSignOutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    // Add left and right padding to specified text fields
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}
