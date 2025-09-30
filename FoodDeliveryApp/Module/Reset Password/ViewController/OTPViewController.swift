import UIKit
import DPOTPView

class OTPViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var otpView2: UIView!
    @IBOutlet weak var btnDidNotReceive: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var otpView: DPOTPView!
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        // Set custom title with a back button
        setLeftAlignedTitleWithBack(Main.setTitle.resetPasswordTitle, target: self, action: #selector(otpBackBtnTapped))
        
        // Group all OTP text fields for setup
        // Apply rounded style to Next button
        viewStyle(cornerRadius: 28 , borderWidth: 0, borderColor: .systemGray, textField: [btnNext])
        
        // Localized UI setup
        reloadLocalizedData()
        
        let txtOTPView = DPOTPView(
            frame: CGRect(
                x: (self.view.frame.width - 250) / 2,
                y: otpView.frame.origin.y + 50,
                width: 250,
                height: 60
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
        // Theme DPOTPView text fields
        
        let theme = ThemeManager.shared.currentTheme
        txtOTPView.backGroundColorTextField = theme.backgroundColor
        txtOTPView.textColorTextField = theme.labelTextColor
        txtOTPView.borderColorTextField = theme.labelTextColor.withAlphaComponent(0.3)
        txtOTPView.selectedBorderColorTextField = theme.buttonColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLocalizedData()
        applyTheme()
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
    
    func reloadLocalizedData() {
        lblTitle.text = Main.otpModel.labelTitle
        lblSubTitle.text = Main.otpModel.labelSubTitle
        btnNext.setTitle(Main.otpModel.nextButton, for: .normal)
        setLeftAlignedTitleWithBack(Main.setTitle.resetPasswordTitle, target: self, action: #selector(otpBackBtnTapped))
        // 1. Get the localized string
        let localizedText = Main.otpModel.clickHereButton
        // Example: "Didn't Receive? Click Here"

        // 2. Create a mutable attributed string
        let attributedText = NSMutableAttributedString(string: localizedText)

        // 3. Define your colors
        let grayColor = UIColor(hex: "#7C7D7E")   // for "Didn't Receive?"
        let orangeColor = UIColor(hex: "#FC6011") // for "Click Here"

        // 4. Apply gray to the whole string first
        attributedText.addAttributes([
            .foregroundColor: grayColor,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ], range: NSRange(location: 0, length: attributedText.length))

        // 5. Apply orange only to "Click Here"
        if let range = localizedText.range(of: "Click Here") {
            let nsRange = NSRange(range, in: localizedText)
            attributedText.addAttributes([
                .foregroundColor: orangeColor,
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ], range: nsRange)
        }

        // 6. Set it on the button
        btnDidNotReceive.setAttributedTitle(attributedText, for: .normal)

    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        view.backgroundColor = theme.backgroundColor
        otpView2.backgroundColor = theme.backgroundColor
        otpView.backgroundColor = theme.backgroundColor
        lblTitle.textColor = theme.labelTextColor
        lblSubTitle.textColor = theme.labelTextColor
        
        btnNext.backgroundColor = theme.buttonColor
        btnNext.tintColor = theme.labelTextColor
        btnDidNotReceive.tintColor = theme.labelTextColor
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
