//
//  OrderListViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import UIKit
import Lottie

/// A view controller that displays the list of orders placed by the user.
class OrderListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblOrderList: UITableView!
    
    /// A two-dimensional array containing orders, where each order is an array of `ProductModel` items.
    var orders: [[ProductModel]] = []
    var currentUser: User?
    var emptyAnimationView: LottieAnimationView!
    var emptyLabel: UILabel!
    /**
     Called after the view controller's view has been loaded into memory.
     This is where the UI is set up, data is loaded, and initial configurations are performed.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack(Main.setTitle.orderListTitle, target: self, action: #selector(myOrderBackBtn))
        
        // Do any additional setup after loading the view.
        tblOrderList.register(UINib(nibName: Main.CellIdentifiers.orderListTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.orderListTableViewCell)
        // Setup reusable empty state
        let emptyState = EmptyStateHelper.setupEmptyState(
            in: view,
            animationName: Main.Animation.orderListAnimationName.0,   // name of your Lottie JSON
            message: Main.Animation.orderListAnimationName.1
        )
        emptyAnimationView = emptyState.animationView
        emptyLabel = emptyState.label
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
        tblOrderList.isHidden = isOrderEmpty
        emptyAnimationView.isHidden = !isOrderEmpty
        emptyLabel.isHidden = !isOrderEmpty
        
        if isOrderEmpty {
            emptyAnimationView.play()
            applyTheme()
        } else {
            emptyAnimationView.stop()
        }
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
        applyTheme()
        tblOrderList.reloadData()
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        view.backgroundColor = theme.backgroundColor
        tblOrderList.backgroundColor = theme.backgroundColor
        emptyAnimationView.backgroundColor = theme.backgroundColor
        emptyLabel.textColor = theme.labelTextColor
    }
}
