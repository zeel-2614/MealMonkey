import UIKit
import DPOTPView

class OTPViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnDidNotReceive: UIButton!
    @IBOutlet weak var otpView: DPOTPView!
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set custom title with a back button
        setLeftAlignedTitleWithBack(Main.setTitle.resetPasswordTitle, target: self, action: #selector(otpBackBtnTapped))
        
        // Group all OTP text fields for setup
        // Apply rounded style to Next button
        viewStyle(cornerRadius: 28 , borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
        
        let txtOTPView = DPOTPView(
            frame: CGRect(
                x: (self.view.frame.width - 250) / 2,
                y: otpView.frame.origin.y + 50,
                width: 250,
                height: 150
            )
        )
        
        // Basic setup
        txtOTPView.count = 4
        txtOTPView.spacing = 10
        txtOTPView.fontTextField = UIFont.systemFont(ofSize: 20, weight: .medium)
        txtOTPView.borderWidthTextField = 1
        txtOTPView.borderColorTextField = .lightGray
        txtOTPView.selectedBorderColorTextField = .lightGray  // << KEEP border color same when active
        txtOTPView.cornerRadiusTextField = 4
        txtOTPView.backGroundColorTextField = .white
        txtOTPView.isCursorHidden = false
        txtOTPView.dismissOnLastEntry = true
        
        view.addSubview(txtOTPView)
        
    }
    
    // MARK: - Navigation
    @objc func otpBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    @IBAction func btnNextClick(_ sender: Any) {
        // If OTP is valid, navigate to NewPasswordViewController
        let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.newPasswordViewController) as? NewPasswordViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnDidNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(title: Main.profileAlert.successAlertTitle, message: Main.profileAlert.otpSuccessMessage, viewController: self)
    }
}

extension OTPViewController : DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}
