//
//  CheckoutViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnTrackYourOrder: UIButton!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitleWithBack("Checkout",
                                    target: self,
                                    action: #selector(checkoutBackBtn))
        
        viewEnterCard.isHidden = true
        viewTransparent.isHidden = true
        viewThankYou.isHidden = true
        
        viewAddCard2.layer.cornerRadius = 20
        viewAddCard2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewAddCard2.layer.shadowColor = UIColor.black.cgColor
        viewAddCard2.layer.shadowOpacity = 0.2
        viewAddCard2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewAddCard2.layer.shadowRadius = 10
        
        viewThankYou2.layer.cornerRadius = 20
        viewThankYou2.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewThankYou2.layer.shadowColor = UIColor.black.cgColor
        viewThankYou2.layer.shadowOpacity = 0.2
        viewThankYou2.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewThankYou2.layer.shadowRadius = 10
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtCardNumber, txtExpiryMonth, txtExpiryYear, txtSecurityCode, txtFirstName, txtLastName, btnEnterCard, btnTrackYourOrder, btnSendOrder])
        
        setPadding(textfield: [txtCardNumber, txtFirstName, txtLastName, txtExpiryYear, txtExpiryMonth, txtSecurityCode])
        
        tblCheckout.backgroundColor = .clear
        tblCheckout.showsVerticalScrollIndicator = false
        tblCheckout.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        tblCheckout.register(UINib(nibName: "GmailTableViewCell", bundle: nil), forCellReuseIdentifier: "GmailTableViewCell")
        tblCheckout.register(UINib(nibName: "VisaTableViewCell", bundle: nil), forCellReuseIdentifier: "VisaTableViewCell")
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
    
    @IBAction func btnTrackYourOrderClick(_ sender: Any) {
    }
}
