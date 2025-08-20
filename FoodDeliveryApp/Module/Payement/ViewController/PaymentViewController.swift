import UIKit

/// View controller for managing saved payment cards and adding new cards.
class PaymentViewController: UIViewController {
    
    // MARK: - IBOutlets
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
    
    // MARK: - Properties
    /// Array storing saved card numbers.
    var arrCards: [String] = []
    
    // MARK: - Lifecycle Methods
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAddCard.isHidden = true
        setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backBtnTapped))
        setCartButton(target: self, action: #selector(btnCartPressed))
        
        setupUI()
        tblCardDetails.showsVerticalScrollIndicator = false
        tblCardDetails.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
        
        if let savedCards = UserDefaults.standard.array(forKey: "savedCards") as? [String] {
            arrCards = savedCards
        }
    }
    // MARK: - Helper Methods
    /**
     Adds left and right padding to the given text fields.
     - Parameter textfield: Array of `UITextField` objects to apply padding to.
     */
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Navigates back to the previous screen when back button is tapped.
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Navigates to the cart view when the cart button is pressed.
    @objc func btnCartPressed() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    // MARK: - Actions
    /**
     Handles the tap action for "Add New Card" button.
     - Clears the card entry fields.
     - Shows the add card form with animation.
     - Focuses on the card number text field.
     */
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
    
    /**
     Handles the tap action for closing the add card view.
     - Animates the view sliding down.
     - Restores the tab bar visibility.
     */
    @IBAction func btnCloseAddCardViewClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewAddCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewAddCard.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            
        }
    }
    
    /// Action triggered when the remove card switch value changes.
    @IBAction func valueRemoveCardSwitch(_ sender: Any) {
    }
    
    /**
     Handles the "Add Card" button action.
     - Validates card details.
     - Shows a confirmation alert before saving.
     - Saves the card to `UserDefaults` if confirmed.
     */
    @IBAction func btnAddCardClick(_ sender: Any) {
        // Validation
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
        
        // Show Confirmation Alert
        let confirmAlert = UIAlertController(
            title: "Confirm Card Details",
            message: "Card Number: \(cardNumber)\nExpiry: \(expiryMonth)/\(expiryYear)\nDo you want to save this card?",
            preferredStyle: .alert
        )
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        confirmAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            // Save card
            self.arrCards.append(cardNumber)
            self.saveCardsToDefaults()
            self.tblCardDetails.reloadData()
            self.btnCloseAddCardViewClick(sender)
        }))
        present(confirmAlert, animated: true)
    }
    
    /**
     Displays an alert with a given message.
     - Parameter message: The message to display in the alert.
     */
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    /// Clears all the text fields in the add card form.
    func clearCardEntryFields() {
        txtCardNumber.text = ""
        txtExpiryMonth.text = ""
        txtExpiryYear.text = ""
        txtSecurityCode.text = ""
        txtFirstName.text = ""
        txtLastName.text = ""
    }
    
    func setupUI() {
        // Style the add card buttons
        viewStyle(
            cornerRadius: btnAddCard.frame.size.height / 2,
            borderWidth: 0,
            borderColor: .systemGray,
            textField: [btnAddCard, btnAddNewCard]
        )
        
        // Style the text fields for card details
        viewStyle(
            cornerRadius: 28,
            borderWidth: 0,
            borderColor: .gray,
            textField: [txtLastName, txtFirstName, txtExpiryYear, txtCardNumber, txtExpiryMonth, txtSecurityCode]
        )
        
        // Add padding to text fields
        setPadding(textfield: [txtLastName, txtFirstName, txtCardNumber, txtExpiryYear, txtExpiryMonth, txtSecurityCode])
        
        // Style the add card view
        viewAddCard.layer.cornerRadius = 20
        viewAddCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard.layer.shadowColor = UIColor.black.cgColor
        viewAddCard.layer.shadowOpacity = 0.2
        viewAddCard.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard.layer.shadowRadius = 10
        
        // Style the scroll view
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
    }
    
}
