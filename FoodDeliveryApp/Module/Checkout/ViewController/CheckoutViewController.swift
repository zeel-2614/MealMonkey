//
//  CheckoutViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class CheckoutViewController: UIViewController, MapViewControllerDelegate {
    func didSelectAddress(_ address: String) {
        // Remove duplicate place name at start if repeated
        var cleanedAddress = address
        if let firstComma = address.firstIndex(of: ",") {
            let firstPart = address[..<firstComma].trimmingCharacters(in: .whitespaces)
            let rest = address[address.index(after: firstComma)...].trimmingCharacters(in: .whitespaces)
            
            if rest.hasPrefix(firstPart) {
                cleanedAddress = rest // drop the duplicate
            }
        }
        
        // Now split into two lines max
        if let commaIndex = cleanedAddress.firstIndex(of: ",") {
            let firstLine = cleanedAddress[..<commaIndex].trimmingCharacters(in: .whitespaces)
            let secondLine = cleanedAddress[address.index(after: commaIndex)...].trimmingCharacters(in: .whitespaces)
            lblDeliveryAddress.text = "\(firstLine)\n\(secondLine)"
        } else {
            lblDeliveryAddress.text = cleanedAddress
        }
        
        lblDeliveryAddress.numberOfLines = 2
        lblDeliveryAddress.lineBreakMode = .byTruncatingTail
    }
    
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
    
    var arrCards : [String] = ["Card -1 ", "card -2 ", "card -3 "]
    var selectedPaymentIndex: Int = 0 // Default COD is selected
    var checkoutSubtotal: Double = 0.0
    var checkoutDeliveryCost: Double = 0.0
    var checkoutTotal: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitleWithBack("Checkout",
                                    target: self,
                                    action: #selector(checkoutBackBtn))
        
        viewEnterCard.isHidden = true
        viewTransparent.isHidden = true
        viewThankYou.isHidden = true
        styleBottomRoundedView(viewAddCard2)
        styleBottomRoundedView(viewThankYou2)
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecurityCode, txtFirstName, txtLastName, btnEnterCard, btnTrackYourOrder, btnSendOrder])
        
        setPadding(textfield: [txtCardNumber, txtFirstName, txtLastName, txtExpiryYear, txtExpiryMonth, txtSecurityCode])
        
        tblCheckout.backgroundColor = .clear
        tblCheckout.showsVerticalScrollIndicator = false
        tblCheckout.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblCheckout.register(UINib(nibName: "GmailTableViewCell", bundle: nil), forCellReuseIdentifier: "GmailTableViewCell")
        tblCheckout.register(UINib(nibName: "VisaTableViewCell", bundle: nil), forCellReuseIdentifier: "VisaTableViewCell")
        
        if let savedCards = UserDefaults.standard.array(forKey: "savedCards") as? [String] {
            arrCards = savedCards
        }
        
        lblSubTotal.text = "$\(String(format: "%.2f", checkoutSubtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", checkoutDeliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", checkoutTotal))"
        
        tblCheckout.reloadData()
    }
    
    @objc func checkoutBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @IBAction func btnChangeAddressClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController{
            VC.delegate = self  // ✅ Set delegate here
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnAddCardClick(_ sender: Any) {
        viewEnterCard.isHidden = false
        viewTransparent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewEnterCard.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    @IBAction func btnSendOrderClick(_ sender: Any) {
        viewThankYou.isHidden = false
        viewTransparent.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.viewThankYou.transform = .identity
        }
        setTabBar(hidden: true)
    }
    
    @IBAction func btnCrossClikc(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEnterCard.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewEnterCard.isHidden = true
            self.viewTransparent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
    @IBAction func btnEnterCardClick(_ sender: Any) {
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
        
        // ✅ Confirmation Alert before saving
        let confirmAlert = UIAlertController(title: "Confirm Card",
                                             message: "Do you want to save this card?",
                                             preferredStyle: .alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        confirmAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            // Load existing cards from UserDefaults
            var savedCards = UserDefaults.standard.array(forKey: "savedCards") as? [String] ?? []
            savedCards.append(cardNumber)
            
            // Save back to UserDefaults
            UserDefaults.standard.set(savedCards, forKey: "savedCards")
            
            // Update local arrCards
            self.arrCards = savedCards
            self.tblCheckout.reloadData()
            
            // Close enter card view
            self.btnCrossClikc(sender)
        }))
        
        present(confirmAlert, animated: true)
        tblCheckout.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func btnThankYouCrossClick(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewThankYou.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        }) { _ in
            self.viewThankYou.isHidden = true
            self.viewTransparent.isHidden = true
            self.setTabBar(hidden: false)
        }
    }
    
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
    
    func styleBottomRoundedView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 10
    }
    
    @IBAction func btnTrackYourOrderClick(_ sender: Any) {
    }
    
    @IBAction func btnBackToHomeClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let mlvc = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController {
            self.navigationController?.pushViewController(mlvc, animated: true)
        }
    }
}
