import UIKit
import CoreData

// MARK: - LoginViewController
/// Handles the login functionality, including email/password validation,
/// navigation to main app content, and links to sign-up/forgot password.
class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblLoginTitle: UILabel!
    @IBOutlet weak var loginView2: UIView!
    @IBOutlet weak var lblOrLogin: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblLoginDetails: UILabel!
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
        applyTheme()
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, txtPassword, btnLogin, btnGoogle, btnFacebook])
        
        setPadding(textfield: [txtEmail, txtPassword])
        reloadLocalizedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Keep navigation and tab bars hidden when the view appears
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        reloadLocalizedData()
        applyTheme()
    }
    
    /// Validates user input for login and navigates to the main tab bar if valid.
    func validateLoginPassword() {
        guard let email = txtEmail.text, !email.isEmpty else {
            UIAlertController.showAlert(title: Main.loginAlert.errorTitle, message: Main.loginAlert.emailErrorMessage, viewController: self)
            return
        }
        guard let password = txtPassword.text, !password.isEmpty else {
            UIAlertController.showAlert(title: Main.loginAlert.errorTitle, message: Main.loginAlert.passwordErrorMessage, viewController: self)
            return
        }
        guard ValidationHelper.isValidEmail(email) else {
            UIAlertController.showAlert(title: Main.loginAlert.validEmailAlertTitle, message: Main.loginAlert.validEmailMessage, viewController: self)
            return
        }
        guard ValidationHelper.isValidPassword(password) else {
            UIAlertController.showAlert(title: Main.loginAlert.validPasswordAlertTitle, message: Main.loginAlert.validPasswordMessage, viewController: self)
            return
        }
        // Core Data Fetch
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Main.loginAlert.emailPasswordFormat, email, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                // Save logged-in user email
                SessionManager.save(email: user.email ?? "")
                UserDefaults.standard.set(true, forKey: Main.Key.isLoggedInKey)
                UserDefaults.standard.synchronize()
                
                // Navigate to Main Tab
                showMainTabBar()
            } else {
                UIAlertController.showAlert(
                    title: Main.loginAlert.loginErrorTitle,
                    message: Main.loginAlert.loginErrorMessage,
                    viewController: self
                )
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
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
        let imageName = isPasswordVisible ? Main.Images.btnPassword : Main.Images.btnPasswordVisible
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    /// Triggered when the "Forgot Password" button is clicked.
    @IBAction func btnForgetPasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.forgetPasswordViewController) as? ForgetPasswordViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /// Triggered when the "Sign Up" button is clicked.
    @IBAction func btnSignUpAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.signUpViewController) as? SignUpViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reloadLocalizedData() {
        // Assign localized text
        txtEmail.placeholder = Main.loginAlert.emailTextField
        txtPassword.placeholder = Main.loginAlert.passwordTextField
        btnLogin.setTitle(Main.loginAlert.loginButton, for: .normal)
        btnFacebook.setTitle(Main.loginAlert.facebookButton, for: .normal)
        btnGoogle.setTitle(Main.loginAlert.googleButton, for: .normal)
        btnForgotPassword.setTitle(Main.loginAlert.forgotPasswordButton, for: .normal)
        
        // Optionally, if you have a label for title/details
        lblLoginTitle.text = Main.loginAlert.screenTitleLabel
        lblLoginDetails.text = Main.loginAlert.loginDetailsLabel
        lblOrLogin.text = Main.loginAlert.orLoginLabel
        
        // 1. Get the localized string
        let localizedText = Main.loginAlert.signupButton
        // Example: "Don't have an Account? Sign Up"

        // 2. Create a mutable attributed string
        let attributedText = NSMutableAttributedString(string: localizedText)

        // 3. Define your colors
        let grayColor = UIColor(hex: "#7C7D7E")   // for "Don't have an Account?"
        let orangeColor = UIColor(hex: "#FC6011") // for "Sign Up"

        // 4. Apply gray to the whole string first
        attributedText.addAttributes([
            .foregroundColor: grayColor,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ], range: NSRange(location: 0, length: attributedText.length))

        // 5. Apply orange only to "Sign Up"
        if let range = localizedText.range(of: "Sign Up") {
            let nsRange = NSRange(range, in: localizedText)
            attributedText.addAttributes([
                .foregroundColor: orangeColor,
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ], range: nsRange)
        }

        // 6. Set it on the button
        btnSignup.setAttributedTitle(attributedText, for: .normal)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme

        // Background
        view.backgroundColor = theme.backgroundColor
        loginView2.backgroundColor = theme.backgroundColor
        loginView.backgroundColor = theme.backgroundColor

        // Labels
        lblLoginTitle.textColor = theme.labelTextColor
        lblOrLogin.textColor = theme.labelTextColor
        lblLoginDetails.textColor = theme.labelTextColor

        // TextFields
        txtEmail.backgroundColor = theme.cardCellBackgroundColor
        txtEmail.textColor = theme.labelTextColor
        txtEmail.tintColor = theme.labelTextColor

        txtPassword.backgroundColor = theme.cardCellBackgroundColor
        txtPassword.textColor = theme.labelTextColor
        txtPassword.tintColor = theme.labelTextColor

        // Buttons
        btnLogin.backgroundColor = theme.buttonColor
        btnLogin.setTitleColor(theme.buttonTextColor, for: .normal)

        btnFacebook.backgroundColor = theme.facebookButtonColor
        btnFacebook.setTitleColor(.white, for: .normal) // Facebook text is usually white

        btnGoogle.backgroundColor = theme.googleButtonColor
        btnGoogle.setTitleColor(.white, for: .normal) // Google text is usually white

        btnSignup.setTitleColor(theme.labelTextColor, for: .normal)
        btnForgotPassword.setTitleColor(theme.labelTextColor, for: .normal)
        btnEye.tintColor = theme.labelTextColor
    }
}
