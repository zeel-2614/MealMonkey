import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
    @IBOutlet weak var btnConfirmPasswordEye: UIButton!
    @IBOutlet weak var btnPasswordEye: UIButton!
    @IBOutlet weak var txtConfiemPassword: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    var isPasswordVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("New Password", target: self, action: #selector(backButtonTapped))
        self.navigationController?.isNavigationBarHidden = false
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtNewPassword, txtConfiemPassword, btnNext])
        
        setPadding(textfield: [txtNewPassword, txtConfiemPassword])
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "NextPageViewController") as? NextPageViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnPasswordEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtConfiemPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    @IBAction func btnConfirmPasswordEyeClick(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        txtNewPassword.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        if let button = sender as? UIButton {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
