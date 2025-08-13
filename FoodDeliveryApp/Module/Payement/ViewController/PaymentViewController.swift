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
    
    var arrCards: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAddCard.isHidden = true
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backBtnTapped))
        setCartButton(target: self, action: #selector(btnCartPressed))
        
        viewStyle(cornerRadius: btnAddCard.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [btnAddCard, btnAddNewCard])
        
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
        
        if let savedCards = UserDefaults.standard.array(forKey: "savedCards") as? [String] {
            arrCards = savedCards
        }
        
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartPressed() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @IBAction func btnAddNewCardClick(_ sender: Any) {
        clearCardEntryFields()
        viewAddCard.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewAddCard.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        } completion: { _ in
            // ✅ Focus on card number field
            self.txtCardNumber.becomeFirstResponder()
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
        // 1️⃣ Validation
        guard let cardNumber = txtCardNumber.text, cardNumber.count == 16 else {
            showAlert(message: "Card number must be exactly 16 digits.")
            return
        }
        guard let expiryMonth = txtExpiryMonth.text, expiryMonth.count == 2 else {
            showAlert(message: "Expiry month must be 2 digits.")
            return
        }
        guard let expiryYear = txtExpiryYear.text, expiryYear.count == 2 else {
            showAlert(message: "Expiry year must be 2 digits.")
            return
        }
        
        // 2️⃣ Show Confirmation Alert
        let confirmAlert = UIAlertController(
            title: "Confirm Card Details",
            message: "Card Number: \(cardNumber)\nExpiry: \(expiryMonth)/\(expiryYear)\nDo you want to save this card?",
            preferredStyle: .alert
        )
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        confirmAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            // 3️⃣ Save card
            self.arrCards.append(cardNumber)
            self.saveCardsToDefaults()
            self.tblCardDetails.reloadData()
            self.btnCloseAddCardViewClick(sender)
        }))
        
        present(confirmAlert, animated: true)
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func clearCardEntryFields() {
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
        txtSecurityCode.text = ""
        txtFirstName.text = ""
        txtLastName.text = ""
    }
}
