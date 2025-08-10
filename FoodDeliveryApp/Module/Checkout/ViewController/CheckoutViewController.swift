//
//  CheckoutViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class CheckoutViewController: UIViewController {

    
    var arrCards : [String] = ["Card -1 ", "card -2 ", "card -3 "]
    
    @IBOutlet weak var thankyouViewScroll: UIView!
    @IBOutlet weak var addNewCardView: UIView!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnBackToHome: UIButton!
    @IBOutlet weak var txtExpiryMonth: UITextField!
    
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet weak var btnCardAdded: UIButton!
    @IBOutlet weak var txtExpiryYear: UITextField!
    @IBOutlet weak var btnTrackOrder: UIButton!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var thankYouPageView: UIView!
    @IBOutlet weak var btnAddCard: UIButton!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var tblCheckout: UITableView!
    @IBOutlet weak var btnSendOrder: UIButton!
    @IBOutlet weak var btnChangeAddress: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        thankYouPageView.isHidden = true
        addNewCardView.isHidden = true

        // Do any additional setup after loading the view.
        tblCheckout.register(UINib(nibName: "CashOnDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "CashOnDeliveryTableViewCell")
        
        tblCheckout.register(UINib(nibName: "GmailTableViewCell", bundle: nil), forCellReuseIdentifier: "GmailTableViewCell")
        
        tblCheckout.register(UINib(nibName: "VisaTableViewCell", bundle: nil), forCellReuseIdentifier: "VisaTableViewCell")
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("Checkout", target: self, action: #selector(checkoutBackBtn))
        // Do any additional setup after loading the view.
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [btnSendOrder, btnTrackOrder, btnCardAdded, txtLastName, txtFirstName, txtExpiryYear,txtCardNumber, txtExpiryMonth, txtSecurityCode])
        
        setPadding(textfield: [txtLastName, txtFirstName,txtCardNumber, txtExpiryYear, txtExpiryMonth, txtSecurityCode])
        
        addNewCardView.layer.cornerRadius = 20
        addNewCardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addNewCardView.layer.shadowColor = UIColor.black.cgColor
        addNewCardView.layer.shadowOpacity = 0.2
        addNewCardView.layer.shadowOffset = CGSize(width: 0, height: -2)
        addNewCardView.layer.shadowRadius = 10
        
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.2
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
        thankYouPageView.layer.cornerRadius = 20
        thankYouPageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        thankYouPageView.layer.shadowColor = UIColor.black.cgColor
        thankYouPageView.layer.shadowOpacity = 0.2
        thankYouPageView.layer.shadowOffset = CGSize(width: 0, height: -2)
        thankYouPageView.layer.shadowRadius = 10
        
        thankyouViewScroll.layer.cornerRadius = 20
        thankyouViewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        thankyouViewScroll.layer.shadowColor = UIColor.black.cgColor
        thankyouViewScroll.layer.shadowOpacity = 0.2
        thankyouViewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        thankyouViewScroll.layer.shadowRadius = 10
        
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @objc func checkoutBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSendOrderClick(_ sender: Any) {
        thankYouPageView.isHidden = false
    }
    
    @IBAction func btnChangeAddressClick(_ sender: Any) {
    }
    
    @IBAction func btnAddCardClick(_ sender: Any) {
        addNewCardView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.addNewCardView.transform = .identity
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    @IBAction func btnCloseClick(_ sender: Any) {
        addNewCardView.isHidden = true
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.addNewCardView.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.view.frame.height
                )
            }
        ) { _ in
            self.addNewCardView.isHidden = true
        }

    }
    @IBAction func btnTrackOrderClick(_ sender: Any) {
        
    }
    @IBAction func btnCardAddedClick(_ sender: Any) {
        
    }
    @IBAction func btnBackToHomeClikc(_ sender: Any) {
        
    }
}
