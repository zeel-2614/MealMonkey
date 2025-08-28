import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
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
        setCartButtonWithBadge(target: self, action: #selector(btnCartTapped))
        // Add listeners to text fields for change detection
        [txtName, txtEmail, txtMobileNo, txtAddress].forEach {
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        loadUserData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
    }
    
    func updateSaveButtonState() {
        guard let user = currentUser else { return }
        
        let hasChanges =
        txtName.text != user.name ||
        txtEmail.text != user.email ||
        txtMobileNo.text != user.mobile ||
        txtAddress.text != user.address ||
        (imgProfile.image?.jpegData(compressionQuality: 0.8) != user.profileImage)
        
        btnSave.isUserInteractionEnabled = hasChanges
        btnSave.backgroundColor = hasChanges ? .buttonBackground : .lightGray
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
                
                // Set username label
                lblUserName.text = "Hello there, \(user.name ?? "User")"
                updateSaveButtonState()
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
        updateSaveButtonState()
    }
    
    // Sign out and navigate to login screen
    @IBAction func btnSignOutClick(_ sender: Any) {
        // Clear session data
        SessionManager.clear()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
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
        
        // Normalize strings to avoid nil vs. empty or spacing issues
        let nameChanged = (txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.name ?? "")
        let emailChanged = (txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.email ?? "")
        let mobileChanged = (txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.mobile ?? "")
        let addressChanged = (txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.address ?? "")
        
        // Compare images in a safer way
        let profileImageData = imgProfile.image?.jpegData(compressionQuality: 0.8)
        let imageChanged: Bool

        if let existingData = user.profileImage {
            imageChanged = profileImageData != existingData
        } else {
            // Only mark as changed if the user actually picked a new image
            imageChanged = imgProfile.image != UIImage(named: "placeholderProfile")
        }
        // Detect if there are NO changes
        if !nameChanged && !emailChanged && !mobileChanged && !addressChanged && !imageChanged {
            UIAlertController.showAlert(
                title: "Info",
                message: "No changes detected.",
                viewController: self
            )
            return
        }
        
        // Proceed with save only if something changed
        do {
            user.name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.mobile = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.address = txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.profileImage = profileImageData
            
            try context.save()
            currentUser = user
            
            UIAlertController.showAlert(
                title: "Success",
                message: "Profile updated successfully!",
                viewController: self
            )
            
            updateSaveButtonState()
        } catch {
            print("❌ Failed to update user: \(error.localizedDescription)")
        }
    }
}
