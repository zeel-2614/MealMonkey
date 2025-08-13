//
//  MyOrderViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

class MyOrderViewController: UIViewController {
    
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var tblOrder: UITableView!
    
    var orderProducts: [ProductModel] = []
    let deliveryCost: Double = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack("My Order", target: self, action: #selector(myOrderBackBtn))
        // Do any additional setup after loading the view.
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [btnCheckout])
        
        tblOrder.register(UINib(nibName: "MyOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrderTableViewCell")
        
        calculateTotals()
    }
    
    func calculateTotals() {
        let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        lblSubTotal.text = "$\(String(format: "%.2f", subtotal))"
        lblDeliveryCost.text = "$\(String(format: "%.2f", deliveryCost))"
        lblTotal.text = "$\(String(format: "%.2f", subtotal + deliveryCost))"
    }
    @objc func myOrderBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckoutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoreStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController {
            let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
            let total = subtotal + deliveryCost
            
            VC.checkoutSubtotal = subtotal
            VC.checkoutDeliveryCost = deliveryCost
            VC.checkoutTotal = total
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
