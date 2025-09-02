//
//  CheckoutViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

/// A view controller that manages the checkout process, including payment method selection, address changes, and order confirmation.
class CheckoutViewController: UIViewController, ChangeAddressDelegate {
    
    // MARK: - Delegate Method
    
    /// Called when a new address is selected from the address list.
    /// - Parameter address: The selected delivery address as a string.
    func didSelectAddress(_ address: String) {
        lblDeliveryAddress.text = address
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnTrackYourOrder: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var btnThankYouCross: UIButton!
    @IBOutlet weak var viewThankYou2: UIView!
    @IBOutlet weak var viewThankYou: UIView!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var btnEnterCard: UIButton!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var viewAddCard2: UIView!
    @IBOutlet weak var viewEnterCard: UIView!
    @IBOutlet weak var viewTransparent: UIView!
    @IBOutlet weak var tblCheckout: UITableView!
    @IBOutlet weak var btnChangeAddress: UIButton!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var btnSendOrder: UIButton!
    
    // MARK: - Properties
    var arrCards: [String] = []     // was ["Card -1 ", "card -2 ", "card -3 "]
    var currentUser: User?
    var selectedPaymentIndex: Int = 0
    var checkoutSubtotal: Double = 0.0
    var checkoutDeliveryCost: Double = 0.0
    var checkoutTotal: Double = 0.0
    var discount: Double = 4.0
    
    // MARK: - Lifecycle Methods
    
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title with back button
        setLeftAlignedTitleWithBack("Checkout", target: self, action: #selector(checkoutBackBtn))
        
        setupUI()
        // Table view configuration
        tblCheckout.backgroundColor = .clear
        tblCheckout.showsVerticalScrollIndicator = false
        tblCheckout.register(UINib(nibName: Main.CellIdentifiers.cashOnDeliveryTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.cashOnDeliveryTableViewCell)
        tblCheckout.register(UINib(nibName: Main.CellIdentifiers.gmailTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.gmailTableViewCell)
        tblCheckout.register(UINib(nibName: Main.CellIdentifiers.visaTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.visaTableViewCell)
        
        currentUser = CoreDataManager.shared.getOrCreateCurrentUser()
        
        // Load saved cards if available
        if let user = currentUser {
            arrCards = CoreDataManager.shared.fetchCards(for: user).compactMap { $0.number }
        }
        
        updateCheckoutLabels()
        
        tblCheckout.reloadData()
    }
    
    /// Called before the view appears on screen.
    override func viewWillAppear(_ animated: Bool) {
        if let user = currentUser {
            arrCards = CoreDataManager.shared.fetchCards(for: user).compactMap { $0.number }
            tblCheckout.reloadData()
        }
        
        if let savedAddress = UserDefaults.standard.string(forKey: "currentAddress") {
            lblDeliveryAddress.text = savedAddress
        }
    }
    
    // MARK: - Navigation
    /// Action for navigating back from the checkout screen.
    @objc func checkoutBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - UI Helpers
    
    /// Adds left and right padding to an array of text fields.
    /// - Parameter textfield: An array of `UITextField` objects to apply padding to.
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    // MARK: - IBActions
    
    /// Opens the address selection screen.
    @IBAction func btnChangeAddressClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.moreStoryBoard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.addressViewController) as? AddressViewController{
            VC.delegate = self  // ✅ Set delegate here
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Opens the add card entry form.
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
        viewTransparent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewEnterCard.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    /// Shows the thank you screen after order placement.
    @IBAction func btnSendOrderClick(_ sender: Any) {
        viewThankYou.isHidden = false
        viewTransparent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewThankYou.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    /// Closes the add card entry form.
    @IBAction func btnCrossClikc(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransparent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
    /// Validates and saves a new card to user defaults.
    @IBAction func btnEnterCardClick(_ sender: Any) {
        // Validate card number
        guard let cardNumber = txtCardNumber.text, cardNumber.count == 16 else {
            showAlert(message: "Card number must be exactly 16 digits.")
            return
        }
        
        // Validate expiry month
        guard let expiryMonth = txtExpiryMonth.text,
              let month = Int(expiryMonth),
              expiryMonth.count == 2,
              (1...12).contains(month) else {
            showAlert(message: "Expiry month must be between 01 and 12.")
            return
        }
        
        // Validate expiry year
        guard let expiryYear = txtExpiryYear.text,
              let year = Int(expiryYear),
              expiryYear.count == 2 else {
            showAlert(message: "Expiry year must be 2 digits.")
            return
        }
        
        // Validate security code
        guard let securityCode = txtSecurityCode.text, securityCode.count == 3 else {
            showAlert(message: "Security Code must be 3 digits.")
            return
        }
        
        // ✅ Validate expiry is not in the past
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate) % 100  // Last two digits
        let currentMonth = calendar.component(.month, from: currentDate)
        
        if year < currentYear || (year == currentYear && month < currentMonth) {
            showAlert(message: "Card expiry date cannot be in the past.")
            return
        }
        
        // Confirmation Alert
        let confirmAlert = UIAlertController(title: "Confirm Card",
                                             message: "Do you want to save this card?",
                                             preferredStyle: .alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        confirmAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let user = self.currentUser {
                CoreDataManager.shared.addCard(
                    for: user,
                    number: cardNumber,
                    expiryMonth: expiryMonth,
                    expiryYear: expiryYear,
                    securityCode: securityCode,
                    firstName: self.txtFirstName.text ?? "",
                    lastName: self.txtLastName.text ?? ""
                )
                self.arrCards = CoreDataManager.shared.fetchCards(for: user).compactMap { $0.number }
            }
            self.tblCheckout.reloadData()
            self.btnCrossClikc(sender) // Close the sheet
        }))
        
        present(confirmAlert, animated: true)
        tblCheckout.reloadData()
    }
    
    /// Shows an alert with a given message.
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    /// Closes the thank you screen.
    @IBAction func btnThankYouCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewThankYou.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewThankYou.isHidden = true
            self.viewTransparent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
    /// Shows or hides the tab bar.
    /// - Parameters:
    ///   - hidden: A Boolean indicating whether the tab bar should be hidden.
    ///   - animated: A Boolean indicating whether the action should be animated. Defaults to `true`.
    func setTabBar(hidden: Bool, animated: Bool = true) {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        
        let frame = tabBar.frame
        let offsetY = hidden ? UIScreen.main.bounds.height : UIScreen.main.bounds.height - frame.height
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                tabBar.frame.origin.y = offsetY
            }
        } else {
            tabBar.frame.origin.y = offsetY
        }
    }
    
    /// Applies a rounded-top style to a given view with shadow.
    /// - Parameter view: The `UIView` to be styled.
    func styleBottomRoundedView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 10
    }
    
    private func setupUI() {
        viewEnterCard.isHidden = true
        viewTransparent.isHidden = true
        viewThankYou.isHidden = true
        
        styleBottomRoundedView(viewAddCard2)
        styleBottomRoundedView(viewThankYou2)
        
        viewStyle(
            cornerRadius: 28,
            borderWidth: 0,
            borderColor: .systemGray,
            textField: [
                txtCardNumber, txtExpiryMonth, txtExpiryYear,
                txtSecurityCode, txtFirstName, txtLastName,
                btnEnterCard, btnTrackYourOrder, btnSendOrder
            ]
        )
        
        setPadding(textfield: [
            txtCardNumber, txtFirstName, txtLastName,
            txtExpiryYear, txtExpiryMonth, txtSecurityCode
        ])
    }
    
    /// Updates the checkout summary labels with formatted prices.
    private func updateCheckoutLabels() {
        lblSubTotal.text = formatPrice(checkoutSubtotal)
        lblDiscount.text = formatPrice(discount)
        lblDeliveryCost.text = formatPrice(checkoutDeliveryCost)
        
        let discountedTotal = max(0, (checkoutSubtotal - discount) + checkoutDeliveryCost)
        lblTotal.text = formatPrice(discountedTotal)
    }
    
    /// Formats a numeric value into a currency string.
    /// - Parameter value: The value to be formatted.
    /// - Returns: A string in the format `$xx.xx`.
    private func formatPrice(_ value: Double) -> String {
        return "$\(String(format: "%.2f", value))"
    }
    
    /// Action triggered when tracking an order. Currently unimplemented.
    @IBAction func btnTrackYourOrderClick(_ sender: Any) {
    }
    
    /// Navigates back to the home menu screen.
    @IBAction func btnBackToHomeClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.homeStoryBoard, bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.menuViewController) as? MenuViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}
