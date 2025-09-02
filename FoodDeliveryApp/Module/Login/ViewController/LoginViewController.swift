import UIKit
import CoreData

// MARK: - LoginViewController
/// Handles the login functionality, including email/password validation,
/// navigation to main app content, and links to sign-up/forgot password.
class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    // MARK: - Properties
    /// Tracks whether the password is currently visible
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, txtPassword, btnLogin, btnGoogle, btnFacebook])
        
        setPadding(textfield: [txtEmail, txtPassword])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Keep navigation and tab bars hidden when the view appears
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    /// Validates user input for login and navigates to the main tab bar if valid.
    func validateLoginPassword() {
        guard let email = txtEmail.text, !email.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please enter your email address.", viewController: self)
            return
        }
        guard let password = txtPassword.text, !password.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please enter your password.", viewController: self)
            return
        }
        guard ValidationHelper.isValidEmail(email) else {
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address.", viewController: self)
            return
        }
        guard ValidationHelper.isValidPassword(password) else {
            UIAlertController.showAlert(title: "Invalid Password", message: "Password must include uppercase, lowercase, number, and special character.", viewController: self)
            return
        }
        // ✅ Core Data Fetch
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                // ✅ Save logged-in user email
                SessionManager.save(email: user.email ?? "")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                
                // Navigate to Main Tab
                showMainTabBar()
            } else {
                UIAlertController.showAlert(
                    title: "Login Failed",
                    message: "User not registered or invalid email or password.",
                    viewController: self
                )
            }
        } catch {
            print("❌ Fetch error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Actions
    /// Triggered when the login button is clicked.
    @IBAction func btnLoginClick(_ sender: Any) {
        validateLoginPassword()
    }
    
    /// Navigates to the main tab bar controller after successful login.
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.Storyboards.homeStoryBoard, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.mainTabBarViewController) as? UITabBarController {
            
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
    // MARK: - UI Helpers
    /// Adds left and right padding to given text fields.
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Toggles password visibility when the eye button is clicked.
    @IBAction func btnEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    @IBAction func btnRedirect(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.forgetPasswordViewController) as? ForgetPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    /// Triggered when the "Forgot Password" button is clicked.
    @IBAction func btnForgetPasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.forgetPasswordViewController) as? ForgetPasswordViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            print("Forget Password tapped")
        }
    }
    
    /// Triggered when the "Sign Up" button is clicked.
    @IBAction func btnSignUpAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.signUpViewController) as? SignUpViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            print("Sign Up tapped")
        } else {
            print("❌ Could not instantiate SignUpViewController")
        }
    }
}
