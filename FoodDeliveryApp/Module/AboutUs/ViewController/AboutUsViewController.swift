//
//  AboutUsViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 05/08/25.
//

import UIKit

class AboutUsViewController: UIViewController {
   
    var arrCurrent:[AboutModel] = []

    @IBOutlet weak var tblAboutUs: UITableView!
    
    var objPagetype: PageType = .AboutUs
  //    var arrAboutData = AboutModel.addAboutData()
  //    var arrNotificationData = AboutModel.addNotificationData()
  //    var arrInboxData = AboutModel.addInboxData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch objPagetype {
        case .PayMent:
            print("Payment")
            self.setLeftAlignedTitleWithBack("Payment Details", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
        case .MyOrders:
            print("My Orders")
            self.setLeftAlignedTitleWithBack("My Orders", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
        case .Notification:
//            self.title = "Notification"
            self.setLeftAlignedTitleWithBack("Notifications", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addNotificationData()
        case .Inbox:
//            self.title = "Inbox"
            self.setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addInboxData()
        case .AboutUs:
//            self.title = "About Us"
            self.setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartButtonTapped))
            arrCurrent = AboutModel.addAboutData()
        }
        
        tblAboutUs.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
        self.navigationItem.hidesBackButton = true
//        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func cartButtonTapped() {
        // Handle cart button tap
        print("Cart tapped")
    }
}
