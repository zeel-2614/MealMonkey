import UIKit

// MARK: - ForgetPasswordViewController
/// A view controller responsible for handling the "Forgot Password" flow.
/// It allows users to enter their email to receive an OTP for password recovery.
class ForgetPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show the navigation bar
        self.navigationController?.isNavigationBarHidden = false
        
        // Apply corner radius and styling to the email field and send button
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtEmail, btnSend])
        
        // Add padding inside the email text field
        setPadding(textfield: [txtEmail])
        
        // Set a left-aligned navigation title with a back button
        setLeftAlignedTitleWithBack("Forgot Password", target: self, action: #selector(backButtonTapped))
    }
    // MARK: - Navigation
    /// Handles the back button tap action.
    /// Pops the current view controller from the navigation stack.
    @objc func backButtonTapped() {
        // Go back to the previous screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    /// Adds left and right padding to the specified text fields.
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    // MARK: - Actions
    /// Triggered when the "Send" button is tapped.
    /// Validates the email and shows an appropriate alert.
    /// - Parameter sender: The UI element that triggered the action.
    @IBAction func btnSendClick(_ sender: Any) {
        let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if email.isEmpty {
            // Email field is empty
            UIAlertController.showAlert(title: "Email Missing",
                                        message: "Please enter your Email.",
                                        viewController: self)
        } else if !isValidEmail(email) {
            // Email is not valid
            UIAlertController.showAlert(title: "Invalid Email",
                                        message: "Please enter a valid email address.",
                                        viewController: self)
        } else {
            // Email is valid, show success alert and navigate to OTP
            showAlert(title: "Success",
                      message: "OTP Sent Successfully",
                      viewController: self)
        }
    }
    
    /// Displays an alert with a title and message, and navigates to the OTP screen upon confirmation.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message body of the alert.
    ///   - viewController: The view controller from which to present the alert.
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }))
        
        viewController.present(alert, animated: true)
    }
    
    /// Checks whether a given email string matches the valid email format.
    /// - Parameter email: The email string to validate.
    /// - Returns: A Boolean value indicating whether the email is valid.
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}
