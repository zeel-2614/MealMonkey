//
//  MyOrderViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 08/08/25.
//

import UIKit

/// A view controller that displays the user's current order, calculates totals, and allows checkout.
class MyOrderViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var tblOrder: UITableView!
    
    /// The array holding the ordered products.
    var orderProducts: [ProductModel] = []
    let deliveryCost: Double = 5.0
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setLeftAlignedTitleWithBack(Main.setTitle.myOrderTitle, target: self, action: #selector(myOrderBackBtn))
        // Do any additional setup after loading the view.
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [btnCheckout])
        
        tblOrder.register(UINib(nibName: Main.CellIdentifiers.myOrderTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.myOrderTableViewCell)
        
        calculateTotals()
    }
    
    /// Calculates subtotal, delivery cost, and total, then updates the labels.
    func calculateTotals() {
        let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty!)) }
        lblSubTotal.text = "\(Main.cartAlertMessage.priceSymbol)\(String(format: Main.cartAlertMessage.priceFormat, subtotal))"
        lblDeliveryCost.text = "\(Main.cartAlertMessage.priceSymbol)\(String(format: Main.cartAlertMessage.priceFormat, deliveryCost))"
        lblTotal.text = "\(Main.cartAlertMessage.priceSymbol)\(String(format: Main.cartAlertMessage.priceFormat, subtotal + deliveryCost))"
    }
    
    /// Action triggered when the back button in the navigation bar is tapped.
    @objc func myOrderBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Action triggered when the checkout button is tapped.
    /// - Parameter sender: The UI element that triggered this action.
    @IBAction func btnCheckoutClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.moreStoryBoard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.checkoutViewController) as? CheckoutViewController {
            let subtotal = orderProducts.reduce(0) { $0 + ($1.doubleProductPrice * Double($1.intProductQty ?? 0)) }
            let total = subtotal + deliveryCost
            VC.checkoutSubtotal = subtotal
            VC.checkoutDeliveryCost = deliveryCost
            VC.checkoutTotal = total
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
