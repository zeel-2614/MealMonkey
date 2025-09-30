import UIKit

/// A view controller that allows the user to set a new password and confirm it.
/// Includes secure text entry toggling for password fields.
class NewPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var btnConfirmPasswordEye: UIButton!
    @IBOutlet weak var btnPasswordEye: UIButton!
    @IBOutlet weak var txtConfiemPassword: UITextField!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    // MARK: - Properties
    /// Boolean indicating whether the password fields are visible or hidden.
    var isPasswordVisible: Bool = false
    
    // MARK: - Lifecycle
    /// Called after the controller's view is loaded into memory.
    /// Sets up the navigation bar, styles the UI elements, and applies padding to text fields.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack(Main.setTitle.newPasswordTitle, target: self, action: #selector(backButtonTapped))
        self.navigationController?.isNavigationBarHidden = false
        applyTheme()
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtNewPassword, txtConfiemPassword, btnNext])
        setPadding(textfield: [txtNewPassword, txtConfiemPassword])
        reloadLocalizedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLocalizedData()
        applyTheme()
    }
    // MARK: - Validation
    
    /// Validates the new password and confirm password fields.
    /// Checks for empty fields, password complexity, and matching values.
    /// If valid, navigates to `NextPageViewController`.
    func validateNewPasswordConfirmPassword() {
        guard let newPassword = txtNewPassword.text, !newPassword.isEmpty else {
            UIAlertController.showAlert(title: Main.loginAlert.errorTitle, message: Main.newPasswordAlert.newPasswordErrorMessage, viewController: self)
            return
        }
        guard !ValidationHelper.isValidPassword(newPassword) else {
            UIAlertController.showAlert(
                title: Main.newPasswordAlert.newPasswordAlertTitle,
                message: Main.newPasswordAlert.newPasswordMessage,
                viewController: self
            )
            return
        }
        guard let confirmPassword = txtConfiemPassword.text, !confirmPassword.isEmpty else {
            UIAlertController.showAlert(title: Main.loginAlert.errorTitle, message: Main.newPasswordAlert.confirmPasswordMessage, viewController: self)
            return
        }
        guard confirmPassword == newPassword else {
            UIAlertController.showAlert(title: Main.loginAlert.errorTitle, message: Main.newPasswordAlert.wrongPasswordMessage, viewController: self)
            return
        }
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.nextPageViewController) as? NextPageViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
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
        let imageName = isPasswordVisible ? Main.Images.btnPassword : Main.Images.btnPasswordVisible
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    /// Toggles visibility of the new password field when the eye button is tapped.
    /// - Parameter sender: The button triggering the action.
    @IBAction func btnConfirmPasswordEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? Main.Images.btnPassword : Main.Images.btnPasswordVisible
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    func reloadLocalizedData() {
        lblTitle.text = Main.newPasswordAlert.screenTitle
        lblDescription.text = Main.newPasswordAlert.label
        txtNewPassword.placeholder = Main.newPasswordAlert.newPasswordTextfield
        txtConfiemPassword.placeholder = Main.newPasswordAlert.confirmPasswordTextfield
        btnNext.setTitle(Main.newPasswordAlert.nextButton, for: .normal)
        setLeftAlignedTitleWithBack(Main.setTitle.newPasswordTitle, target: self, action: #selector(backButtonTapped))
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Background
        view.backgroundColor = theme.backgroundColor
        newPasswordView.backgroundColor = theme.backgroundColor
        
        // Labels
        lblTitle.textColor = theme.labelTextColor
        lblDescription.textColor = theme.labelTextColor
        
        // TextFields
        txtNewPassword.backgroundColor = theme.cardCellBackgroundColor
        txtNewPassword.textColor = theme.labelTextColor
        txtNewPassword.tintColor = theme.labelTextColor
        
        txtConfiemPassword.backgroundColor = theme.cardCellBackgroundColor
        txtConfiemPassword.textColor = theme.labelTextColor
        txtConfiemPassword.tintColor = theme.labelTextColor
        
        // Buttons
        btnNext.backgroundColor = theme.buttonColor
        btnNext.setTitleColor(theme.buttonTextColor, for: .normal)
        btnPasswordEye.tintColor = theme.labelTextColor
        btnConfirmPasswordEye.tintColor = theme.labelTextColor
    }
}
