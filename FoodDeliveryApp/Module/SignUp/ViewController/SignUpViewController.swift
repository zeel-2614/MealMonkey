import UIKit
import CoreData

// MARK: - SignUpViewController
class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnConfirmEye: UIButton!
    
    // MARK: - Properties
    var isPasswordVisible: Bool = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        setLeftAlignedTitleWithBack("Sign Up", target: self, action: #selector(signUpBackBtnTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword, btnSignUp])
        setPadding(textfield: [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword])
    }
    
    // MARK: - Form Validation
    func validateSignUpForm() -> Bool {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobileNo.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""

        if name.isEmpty || email.isEmpty || mobile.isEmpty || address.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter all fields.", viewController: self)
            return false
        } else if !ValidationHelper.isValidEmail(email) {
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address.", viewController: self)
            return false
        } else if !ValidationHelper.isValidPassword(password) {
            UIAlertController.showAlert(title: "Invalid Password", message: "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.", viewController: self)
            return false
        } else if password != confirmPassword {
            UIAlertController.showAlert(title: "Passwords Do Not Match", message: "The password and confirm password must be the same.", viewController: self)
            return false
        }
        return true
    }
    // MARK: - Navigation Actions
    @objc func signUpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackToLoginClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if storyboard.instantiateViewController(withIdentifier: "LoginViewController") is LoginViewController{
            self.navigationController?.popViewController(animated: true)
        }
    }
    // MARK: - UI Helpers
    func setPadding(textfield: [UITextField]) {
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    // MARK: - Password Visibility Toggle
    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnConfirmEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // MARK: - Sign Up Button Action
    @IBAction func btnSignUpClick(_ sender: Any) {
        let name = txtName.text ?? ""
            let email = txtEmail.text ?? ""
            let mobile = txtMobileNo.text ?? ""
            let address = txtAddress.text ?? ""
            let password = txtPassword.text ?? ""
            
            if validateSignUpForm() {
                saveUserToCoreData(name: name, email: email, mobile: mobile, address: address, password: password)
            }
    }
}

extension SignUpViewController {
    
    func saveUserToCoreData(name: String, email: String, mobile: String, address: String, password: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // Check if email already exists
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                UIAlertController.showAlert(title: "Error", message: "Email already registered. Please login.", viewController: self)
                return
            }
            
            // Create new User object
            let newUser = User(context: context)
            newUser.name = name
            newUser.email = email
            newUser.mobile = mobile
            newUser.address = address
            newUser.password = password
            
            try context.save()
            print("✅ User saved successfully")
            
            // Navigate to Login
            let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.loginViewController) as? LoginViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        } catch {
            print("❌ Failed to save user: \(error.localizedDescription)")
        }
    }
}
