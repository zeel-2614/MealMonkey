import UIKit

/// A view controller that allows the user to set a new password and confirm it.
/// Includes secure text entry toggling for password fields.
class NewPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var btnConfirmPasswordEye: UIButton!
    @IBOutlet weak var btnPasswordEye: UIButton!
    @IBOutlet weak var txtConfiemPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    // MARK: - Properties
    /// Boolean indicating whether the password fields are visible or hidden.
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle
    /// Called after the controller's view is loaded into memory.
    /// Sets up the navigation bar, styles the UI elements, and applies padding to text fields.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(backButtonTapped))
        self.navigationController?.isNavigationBarHidden = false
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtNewPassword, txtConfiemPassword, btnNext])
        setPadding(textfield: [txtNewPassword, txtConfiemPassword])
    }
    
    // MARK: - Validation
    
    /// Validates the new password and confirm password fields.
    /// Checks for empty fields, password complexity, and matching values.
    /// If valid, navigates to `NextPageViewController`.
    func validateNewPasswordConfirmPassword() {
        guard let newPassword = txtNewPassword.text, !newPassword.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please enter your new password.", viewController: self)
            return
        }
        guard isValidPassword(newPassword) else {
            UIAlertController.showAlert(
                title: "Invalid Password",
                message: "Password must have at least 8 characters, including uppercase, lowercase, a number, and a special symbol.",
                viewController: self
            )
            return
        }
        guard let confirmPassword = txtConfiemPassword.text, !confirmPassword.isEmpty else {
            UIAlertController.showAlert(title: "Error", message: "Please confirm your password.", viewController: self)
            return
        }
        guard confirmPassword == newPassword else {
            UIAlertController.showAlert(title: "Error", message: "Passwords do not match.", viewController: self)
            return
        }
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NextPageViewController") as? NextPageViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Checks whether the given password meets complexity requirements.
    /// - Parameter password: The password string to validate.
    /// - Returns: `true` if the password is valid, `false` otherwise.
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    // MARK: - Actions
    /// Handles back button tap by navigating to the previous screen.
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Adds left and right padding to the given text fields.
    /// - Parameter textfield: An array of `UITextField` to apply padding to.
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Handles the "Next" button tap and navigates to the next page.
    @IBAction func btnNextClick(_ sender: Any) {
        validateNewPasswordConfirmPassword()
    }
    
    /// Toggles visibility of the confirm password field when the eye button is tapped.
    /// - Parameter sender: The button triggering the action.
    @IBAction func btnPasswordEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfiemPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggles visibility of the new password field when the eye button is tapped.
    /// - Parameter sender: The button triggering the action.
    @IBAction func btnConfirmPasswordEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
