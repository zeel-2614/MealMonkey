//
//  WishlistViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 16/08/25.
//

import UIKit
import Lottie

/// A view controller that displays the user's wishlist products in a table view.
class WishlistViewController: UIViewController {
    
    // MARK: - Properties
    /// An array holding the list of wishlist products.
    var wishlistProduct: [Wishlist] = []  // now Wishlist objects
    var emptyAnimationView: LottieAnimationView!
    var emptyLabel: UILabel!
    // MARK: - Outlets
    /// The table view used to display the wishlist items.
    @IBOutlet weak var wishlistView: UIView!
    @IBOutlet weak var tblWishlist: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Set custom navigation title with back button.
        setLeftAlignedTitleWithBack(Main.setTitle.wishlistTitle, target: self, action: #selector(backBtnTapped))
        /// Register the custom table view cell for wishlist items.
        tblWishlist.register(UINib(nibName: Main.CellIdentifiers.wishlistTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.wishlistTableViewCell)
        // Setup reusable empty state
        let emptyState = EmptyStateHelper.setupEmptyState(
            in: view,
            animationName: Main.Animation.wishlistAnimationName.0,   // name of your Lottie JSON
            message: Main.Animation.wishlistAnimationName.1
        )
        emptyAnimationView = emptyState.animationView
        emptyLabel = emptyState.label
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Fetch the wishlist data from the app delegate whenever the view appears.
        loadWishlist()
        applyTheme()
    }
    
    func loadWishlist() {
        guard let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        wishlistProduct = CoreDataManager.shared.fetchWishlist(for: user)
        tblWishlist.reloadData()
        
        let isEmpty = wishlistProduct.isEmpty
        tblWishlist.isHidden = isEmpty
        
        emptyAnimationView.isHidden = !isEmpty
        emptyLabel.isHidden = !isEmpty
        
        if isEmpty {
            emptyAnimationView.play()
        } else {
            emptyAnimationView.stop()
        }
    }
    // MARK: - Navigation
    /// Handles the back button tap by popping the current view controller.
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        view.backgroundColor = theme.backgroundColor
        wishlistView.backgroundColor = theme.backgroundColor
        tblWishlist.backgroundColor = theme.backgroundColor
        tblWishlist.separatorColor = theme.labelTextColor.withAlphaComponent(0.2)
        emptyLabel.textColor = theme.labelTextColor
        emptyAnimationView.backgroundColor = theme.backgroundColor
    }
}
