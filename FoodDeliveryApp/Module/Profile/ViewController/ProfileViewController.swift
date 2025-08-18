import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var currentUser: User? // Store the fetched user
    
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
        
        loadUserData()
    }
    
    func loadUserData() {
        guard let email = UserDefaults.standard.string(forKey: "loggedInUserEmail"),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                currentUser = user
                txtName.text = user.name
                txtEmail.text = user.email
                txtMobileNo.text = user.mobile
                txtAddress.text = user.address
                if let imageData = user.profileImage {
                    imgProfile.image = UIImage(data: imageData)
                }
            }
        } catch {
            print("❌ Failed to load user: \(error.localizedDescription)")
        }
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
    @IBAction func btnSaveClick(_ sender: Any) {
        guard let user = currentUser,
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        user.name = txtName.text
        user.email = txtEmail.text
        user.mobile = txtMobileNo.text
        user.address = txtAddress.text
        if let imageData = imgProfile.image?.jpegData(compressionQuality: 0.8) {
            user.profileImage = imageData
        }
        // If you also want password update -> add here
        
        do {
            try context.save()
            UIAlertController.showAlert(title: "Success", message: "Profile updated successfully!", viewController: self)
        } catch {
            print("❌ Failed to update user: \(error.localizedDescription)")
        }
    }
}
