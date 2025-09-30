import UIKit
import CoreData

// MARK: - SignUpViewController
class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblSignUpTitle: UILabel!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var lblSignUpDetail: UILabel!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnBackToLogin: UIButton!
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
        applyTheme()
        setLeftAlignedTitleWithBack(Main.setTitle.signUpTitle, target: self, action: #selector(signUpBackBtnTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword, btnSignUp])
        setPadding(textfield: [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword])
        // Assign placeholders and button titles
        reloadLocalizedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLocalizedData()
        applyTheme()
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
            UIAlertController.showAlert(title: Main.signUpAlert.missingInfoAlertTitle, message: Main.signUpAlert.missingInfoAlertMessage, viewController: self)
            return false
        } else if !ValidationHelper.isValidEmail(email) {
            UIAlertController.showAlert(title: Main.profileAlert.invalidEmailAlertTitle, message: Main.profileAlert.invalidEmailAlertMessage, viewController: self)
            return false
        } else if !ValidationHelper.isValidPassword(password) {
            UIAlertController.showAlert(title: Main.newPasswordAlert.newPasswordAlertTitle, message: Main.signUpAlert.passwordAlertMessage, viewController: self)
            return false
        } else if password != confirmPassword {
            UIAlertController.showAlert(title: Main.signUpAlert.invalidConfirmPassword, message: Main.signUpAlert.invalidConfirmPasswordMessage, viewController: self)
            return false
        }
        return true
    }
    // MARK: - Navigation Actions
    @objc func signUpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackToLoginClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.loginViewController) is LoginViewController {
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
        let imageName = isPasswordVisible ? Main.Images.btnPassword : Main.Images.btnPasswordVisible
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    @IBAction func btnConfirmEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfirmPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? Main.Images.btnPassword : Main.Images.btnPasswordVisible
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
    
    func reloadLocalizedData() {
        txtName.placeholder = Main.signUpAlert.nameTextField
        txtEmail.placeholder = Main.signUpAlert.emailTextField
        txtMobileNo.placeholder = Main.signUpAlert.mobileTextField
        txtAddress.placeholder = Main.signUpAlert.addressTextField
        txtPassword.placeholder = Main.signUpAlert.passwordTextField
        txtConfirmPassword.placeholder = Main.signUpAlert.confirmPasswordTextField
        btnSignUp.setTitle(Main.signUpAlert.signUpButton, for: .normal)
        lblSignUpTitle.text = Main.signUpAlert.screenTitleLabel
        lblSignUpDetail.text = Main.signUpAlert.signUpDetailLabel
        setLeftAlignedTitleWithBack(Main.setTitle.signUpTitle, target: self, action: #selector(signUpBackBtnTapped))
        
        // 1. Get the localized string
        let localizedText = Main.signUpAlert.loginButton
        // Example: "Already have an Account? Login"

        // 2. Create a mutable attributed string
        let attributedText = NSMutableAttributedString(string: localizedText)

        // 3. Define your colors
        let grayColor = UIColor(hex: "#7C7D7E")   // for "Already have an Account?"
        let orangeColor = UIColor(hex: "#FC6011") // for "Login"

        // 4. Apply gray to the whole string first
        attributedText.addAttributes([
            .foregroundColor: grayColor,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ], range: NSRange(location: 0, length: attributedText.length))

        // 5. Apply orange only to "Login"
        if let range = localizedText.range(of: "Login") {
            let nsRange = NSRange(range, in: localizedText)
            attributedText.addAttributes([
                .foregroundColor: orangeColor,
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ], range: nsRange)
        }

        // 6. Set it on the button
        btnBackToLogin.setAttributedTitle(attributedText, for: .normal)
    }
}

extension SignUpViewController {
    
    func saveUserToCoreData(name: String, email: String, mobile: String, address: String, password: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // Check if email already exists
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Main.loginAlert.emailFormat, email)
        
        do {
            let existingUsers = try context.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                UIAlertController.showAlert(title: Main.signUpAlert.existedEmailAlertTitle, message: Main.signUpAlert.existedEmailAlertMessage, viewController: self)
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
            print("User saved successfully")
            
            // Navigate to Login
            let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.loginViewController) as? LoginViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        view.backgroundColor = theme.backgroundColor
        signupView.backgroundColor = theme.backgroundColor
        signUpView.backgroundColor = theme.backgroundColor
        lblSignUpTitle.textColor = theme.labelTextColor
        lblSignUpDetail.textColor = theme.labelTextColor
        
        [txtName, txtEmail, txtMobileNo, txtAddress, txtPassword, txtConfirmPassword].forEach {
            $0?.backgroundColor = theme.cardCellBackgroundColor    // use an existing color
            $0?.textColor = theme.labelTextColor
            $0?.tintColor = theme.labelTextColor       // use labelTextColor for cursor
        }
        
        btnSignUp.backgroundColor = theme.buttonColor
        btnSignUp.tintColor = theme.labelTextColor
        btnBackToLogin.tintColor = theme.labelTextColor
        btnEye.tintColor = theme.labelTextColor
        btnConfirmEye.tintColor = theme.labelTextColor
    }
}
