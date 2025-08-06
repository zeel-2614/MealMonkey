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
        case .MyOrders:
            print("My Orders")
        case .Notification:
            self.title = "Notification"
            arrCurrent = AboutModel.addNotificationData()
        case .Inbox:
            self.title = "Inbox"
            arrCurrent = AboutModel.addInboxData()
        case .AboutUs:
            self.title = "About Us"
            arrCurrent = AboutModel.addAboutData()
        }
        
        tblAboutUs.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
        
//        tblAboutUs.register(
//            UINib(nibName: "AboutUsTableViewCell", bundle: nil),
//            forCellReuseIdentifier: "AboutUsTableViewCell"
//        )

        // Do any additional setup after loading the view.
    }
}
