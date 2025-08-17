import UIKit

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
    func validateSignUpForm() {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobileNo.text ?? ""
        let address = txtAddress.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""

        // Validate required fields with specific alerts
        if name.isEmpty && email.isEmpty && mobile.isEmpty && address.isEmpty && password.isEmpty && confirmPassword.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter all fields.", viewController: self)
        } else if name.isEmpty && email.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your name and email.", viewController: self)
        } else if email.isEmpty && password.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your email and password.", viewController: self)
        } else if password.isEmpty && confirmPassword.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your password and confirm password.", viewController: self)
        } else if name.isEmpty {
            UIAlertController.showAlert(title: "Name Missing", message: "Please enter your name.", viewController: self)
        } else if email.isEmpty {
            UIAlertController.showAlert(title: "Email Missing", message: "Please enter your email.", viewController: self)
        } else if mobile.isEmpty {
            UIAlertController.showAlert(title: "Mobile Missing", message: "Please enter your mobile number.", viewController: self)
        } else if address.isEmpty {
            UIAlertController.showAlert(title: "Address Missing", message: "Please enter your address.", viewController: self)
        } else if password.isEmpty {
            UIAlertController.showAlert(title: "Password Missing", message: "Please enter your password.", viewController: self)
        } else if confirmPassword.isEmpty {
            UIAlertController.showAlert(title: "Confirm Password Missing", message: "Please confirm your password.", viewController: self)
        } else if !isValidEmail(email) {
            UIAlertController.showAlert(title: "Invalid Email", message: "Please enter a valid email address.", viewController: self)
        } else if !isValidPassword(password) {
            UIAlertController.showAlert(title: "Invalid Password", message: "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.", viewController: self)
        } else if password != confirmPassword {
            UIAlertController.showAlert(title: "Passwords Do Not Match", message: "The password and confirm password must be the same.", viewController: self)
        } else {
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
    // MARK: - Email Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    // MARK: - Password Validation
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
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
        validateSignUpForm()
    }
}
