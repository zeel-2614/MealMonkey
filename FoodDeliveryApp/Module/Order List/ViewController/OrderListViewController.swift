//
//  OrderListViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit

/// A view controller that displays the list of orders placed by the user.
class OrderListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblEmptyOrder: UILabel!
    @IBOutlet weak var tblOrderList: UITableView!
    
    /// A two-dimensional array containing orders, where each order is an array of `ProductModel` items.
    var orders: [[ProductModel]] = []
    var currentUser: User?
    
    /**
     Called after the view controller's view has been loaded into memory.
     This is where the UI is set up, data is loaded, and initial configurations are performed.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Order List", target: self, action: #selector(myOrderBackBtn))
        
        // Do any additional setup after loading the view.
        tblOrderList.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
//        fetchOrders()
    }
    /**
     Action triggered when the back button is tapped.
     Navigates back to the previous screen in the navigation stack.
     */
    @objc func myOrderBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     Updates the UI based on whether the order list is empty.
     - If there are no orders, the empty order label is shown and the table view is hidden.
     - If there are orders, the label is hidden and the table view is displayed.
     */
    private func updateEmptyOrderUI() {
        let isOrderEmpty = orders.isEmpty
        lblEmptyOrder.isHidden = !isOrderEmpty
        tblOrderList.isHidden = isOrderEmpty
    }
    
    /**
     Called just before the view appears on screen.
     - Parameter animated: A Boolean value indicating whether the appearance is animated.
     Updates the empty order UI and reloads the table view data.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        orders = CoreDataManager.shared.fetchOrders(for: user)
        updateEmptyOrderUI()
        tblOrderList.reloadData()
    }
}
