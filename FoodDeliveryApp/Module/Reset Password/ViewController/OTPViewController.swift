import UIKit

class OTPViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtFirstDigit: UITextField!
    @IBOutlet weak var txtSecondDigit: UITextField!
    @IBOutlet weak var txtThirdDigit: UITextField!
    @IBOutlet weak var txtFourthDigit: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDidNotReceive: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set custom title with a back button
        setLeftAlignedTitleWithBack("OTP", target: self, action: #selector(otpBackBtnTapped))
        
        // Group all OTP text fields for setup
        let allviews = [txtFirstDigit!, txtSecondDigit!, txtThirdDigit!, txtFourthDigit!]
        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }
        
        // Apply rounded style to OTP fields
        viewStyle(cornerRadius: 12, borderWidth: 0, borderColor: .systemGray, textField: [txtFirstDigit, txtSecondDigit, txtThirdDigit, txtFourthDigit])
        // Apply rounded style to Next button
        viewStyle(cornerRadius: 28 , borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
    }
    
    // MARK: - Navigation
    @objc func otpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    @IBAction func btnNextClick(_ sender: Any) {
        // Combine all OTP digits into a single string
        let otp = "\(txtFirstDigit.text ?? "")\(txtSecondDigit.text ?? "")\(txtThirdDigit.text ?? "")\(txtFourthDigit.text ?? "")"
        
        // Check if OTP is empty or incomplete
        if otp.count < 4 {
            UIAlertController.showAlert(title: "Error", message: "Please enter the complete 4-digit OTP.", viewController: self)
            return
        }
        
        // If OTP is valid, navigate to NewPasswordViewController
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnDidNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(title: "Success", message: "OTP Sent Successfully", viewController: self)
    }
}
