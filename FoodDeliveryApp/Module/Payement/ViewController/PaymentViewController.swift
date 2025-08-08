import UIKit

class PaymentViewController: UIViewController {
    
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnAddNewCard: UIButton!
    @IBOutlet weak var viewAddCard: UIView!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnCloseAddCardView: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var tblCardDetails: UITableView!
    @IBOutlet weak var switchRemoveCard: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAddCard.isHidden = true
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(btnBackTapped))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        viewStyle(cornerRadius: btnAddCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddCard])
        viewStyle(cornerRadius: btnAddNewCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddNewCard])
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [txtLastName, txtFirstName, txtExpiryYear,txtCardNumber, txtExpiryMonth, txtSecurityCode])
        
        setPadding(textfield: [txtLastName, txtFirstName,txtCardNumber, txtExpiryYear, txtExpiryMonth, txtSecurityCode])
        
        
        tblCardDetails.showsVerticalScrollIndicator = false
        tblCardDetails.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        
        viewAddCard.layer.cornerRadius = 20
        viewAddCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard.layer.shadowColor = UIColor.black.cgColor
        viewAddCard.layer.shadowOpacity = 0.2
        viewAddCard.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard.layer.shadowRadius = 10
        
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddNewCardClick(_ sender: Any) {
        viewAddCard.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
            
        }
    }
    
    @IBAction func btnCloseAddCardViewClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            
        }
    }
    
    @IBAction func valueRemoveCardSwitch(_ sender: Any) {
    }
    
    @IBAction func btnAddCardClick(_ sender: Any) {
    }
}
