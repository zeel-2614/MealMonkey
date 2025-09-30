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
    @IBOutlet weak var lblSubTotalLabel: UILabel!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgRestaurant: UIImageView!
    @IBOutlet weak var lblDeliveryCost: UILabel!
    @IBOutlet weak var lblRestaurantAddress: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var lblDeliveryCostLabel: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDeliveryInstructions: UILabel!
    @IBOutlet weak var lblTotalLabel: UILabel!
    @IBOutlet weak var lblRestaurantRatings: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var lblRestaurantName: UILabel!
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
        
        applyTheme()
        
        calculateTotals()
        lblRestaurantName.text = Main.myOrderModel.restaurantName
        lblRestaurantRatings.text = Main.myOrderModel.rating
        lblRestaurantAddress.text = Main.myOrderModel.address
        lblDeliveryInstructions.text = Main.myOrderModel.deliveryInstruction
        lblSubTotalLabel.text = Main.myOrderModel.subTotal
        lblDeliveryCostLabel.text = Main.myOrderModel.deliveryCost
        lblTotalLabel.text = Main.myOrderModel.total
        btnCheckout.setTitle(Main.myOrderModel.checkout, for: .normal)
        btnAddNotes.setTitle(Main.myOrderModel.addNotes, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLocalData()
        applyTheme()
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
    
    func reloadLocalData() {
        lblRestaurantName.text = Main.myOrderModel.restaurantName
        lblRestaurantRatings.text = Main.myOrderModel.rating
        lblRestaurantAddress.text = Main.myOrderModel.address
        lblDeliveryInstructions.text = Main.myOrderModel.deliveryInstruction
        lblSubTotalLabel.text = Main.myOrderModel.subTotal
        lblDeliveryCostLabel.text = Main.myOrderModel.deliveryCost
        lblTotalLabel.text = Main.myOrderModel.total
        btnCheckout.setTitle(Main.myOrderModel.checkout, for: .normal)
        btnAddNotes.setTitle(Main.myOrderModel.addNotes, for: .normal)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Background
        view.backgroundColor = theme.backgroundColor
        totalView.backgroundColor = theme.backgroundColor
        backView.backgroundColor = theme.backgroundColor
        imgRestaurant.backgroundColor = theme.backgroundColor
        
        // Labels
        lblRestaurantName.textColor = theme.labelTextColor
        lblRestaurantRatings.textColor = theme.labelTextColor
        lblRestaurantAddress.textColor = theme.labelTextColor
        lblDeliveryInstructions.textColor = theme.labelTextColor
        lblSubTotalLabel.textColor = theme.labelTextColor
        lblDeliveryCostLabel.textColor = theme.labelTextColor
        lblTotalLabel.textColor = theme.labelTextColor
        lblSubTotal.textColor = theme.labelTextColor
        lblDeliveryCost.textColor = theme.labelTextColor
        lblTotal.textColor = theme.labelTextColor
        
        // Buttons
        btnCheckout.backgroundColor = theme.buttonColor
        btnCheckout.setTitleColor(theme.buttonTextColor, for: .normal)
        btnAddNotes.backgroundColor = .clear
        btnAddNotes.setTitleColor(theme.labelTextColor, for: .normal)
        
        // Table
        tblOrder.backgroundColor = .clear
    }
}
