import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var profileView2: UIView!
    @IBOutlet weak var btnEditProfile: UIButton!
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
        applyTheme()
        
        viewStyle(cornerRadius: imgProfile.frame.size.width/2, borderWidth: 0, borderColor: .systemGray, textField: [imgProfile])
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtAddress, txtMobileNo, btnSave])
        setPadding(textfield: [txtName, txtEmail, txtAddress, txtMobileNo])
        
        setLeftAlignedTitle(Main.setTitle.profileTitle)
        setCartButtonWithBadge(target: self, action: #selector(btnCartTapped))
        // Add listeners to text fields for change detection
        [txtName, txtEmail, txtMobileNo, txtAddress].forEach {
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        loadUserData()
        reloadLocalizedData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
        if textField == txtName {
            let newName = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            lblUserName.text = newName.isEmpty ? Main.setTitle.profilePageTitle : "Hello there, \(newName)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        reloadLocalizedData()
        applyTheme()
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
        guard let email = UserDefaults.standard.string(forKey: Main.Key.loggedInUserEmailKey),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Main.loginAlert.emailFormat, email)
        
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
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
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
        UserDefaults.standard.set(false, forKey: Main.Key.isLoggedInKey)
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.loginViewController) as? LoginViewController {
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
        let newEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // 1. Check for valid email format using your existing helper
        if !ValidationHelper.isValidEmail(newEmail) {
            UIAlertController.showAlert(
                title: Main.profileAlert.invalidEmailAlertTitle,
                message: Main.profileAlert.invalidEmailAlertMessage,
                viewController: self
            )
            return
        }
        
        // 2. Check if email is already used by another user
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Main.profileAlert.newEmailFormat, newEmail, user)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                UIAlertController.showAlert(
                    title: Main.profileAlert.emailExistAlertTitle,
                    message: Main.profileAlert.emailExistAlertMessage,
                    viewController: self
                )
                return
            }
        } catch {
            print("Error checking duplicate email: \(error.localizedDescription)")
        }
        
        // Proceed with your existing save logic
        let nameChanged = (txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.name ?? "")
        let emailChanged = newEmail != (user.email ?? "")
        let mobileChanged = (txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.mobile ?? "")
        let addressChanged = (txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") != (user.address ?? "")
        
        let profileImageData = imgProfile.image?.jpegData(compressionQuality: 0.8)
        let imageChanged: Bool
        if let existingData = user.profileImage {
            imageChanged = profileImageData != existingData
        } else {
            imageChanged = imgProfile.image != UIImage(named: Main.Images.profileImage)
        }
        
        // If no changes found, alert user
        if !nameChanged && !emailChanged && !mobileChanged && !addressChanged && !imageChanged {
            UIAlertController.showAlert(
                title: Main.profileAlert.noFieldChangedAlert,
                message: Main.profileAlert.noFieldChangedMessage,
                viewController: self
            )
            return
        }
        
        // Save updated data
        do {
            user.name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.email = newEmail
            user.mobile = txtMobileNo.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.address = txtAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            user.profileImage = profileImageData
            
            try context.save()
            currentUser = user
            
            UIAlertController.showAlert(
                title: Main.profileAlert.successAlertTitle,
                message: Main.profileAlert.successAlertMessage,
                viewController: self
            )
            
            updateSaveButtonState()
        } catch {
            print("Failed to update user: \(error.localizedDescription)")
        }
    }
    
    func reloadLocalizedData() {
//        lblUserName.text = Main.profileAlert.helloLabel
        btnSignOut.setTitle(Main.profileAlert.signOutButton, for: .normal)
        btnSave.setTitle(Main.profileAlert.saveButton, for: .normal)
        txtName.placeholder = Main.profileAlert.nameTextField
        txtEmail.placeholder = Main.profileAlert.emailTextField
        txtMobileNo.placeholder = Main.profileAlert.mobileTextField
        txtAddress.placeholder = Main.profileAlert.addressTextField
        btnEditProfile.setTitle(Main.profileAlert.editProfileButton, for: .normal)
        setLeftAlignedTitle(Main.setTitle.profileTitle)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        view.backgroundColor = theme.backgroundColor
        lblUserName.textColor = theme.labelTextColor
        [txtName, txtEmail, txtMobileNo, txtAddress].forEach {
            $0?.backgroundColor = theme.cardCellBackgroundColor       // instead of textFieldBackgroundColor
            $0?.textColor = theme.labelTextColor
            $0?.tintColor = theme.labelTextColor              // instead of primaryColor
        }
        btnSave.backgroundColor = btnSave.isUserInteractionEnabled ? theme.buttonColor : .lightGray
        btnEditProfile.tintColor = theme.labelTextColor       // instead of primaryColor
        btnSignOut.backgroundColor = .clear
        imgProfile.layer.borderColor = theme.labelTextColor.cgColor // instead of primaryColor
        profileView.backgroundColor = theme.backgroundColor
        profileView2.backgroundColor = theme.backgroundColor
    }
}
