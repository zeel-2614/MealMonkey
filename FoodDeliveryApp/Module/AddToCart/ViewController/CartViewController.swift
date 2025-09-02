
import UIKit
import Lottie

/// A view controller responsible for displaying and managing the user's cart.
class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!
    
    /// Computed property that retrieves the current cart items from the AppDelegate.
    // Replace computed property with a stored property
    var cartItems: [CartItems] = []
    var emptyCartAnimationView: LottieAnimationView?
    var lblEmptyCart: UILabel!
    
    /// Called when the view is about to appear on the screen.
    /// - Parameter animated: A Boolean value indicating whether the appearance is animated.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        cartItems = CoreDataManager.shared.fetchCartItems(for: user)
        updateEmptyCartUI()
        tblCartView.reloadData()
    }
    
    func deleteCartItem(at indexPath: IndexPath) {
        guard let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        let productId = Int(cartItems[indexPath.row].productId)
        CoreDataManager.shared.removeCartItem(productId: productId, for: user)
        cartItems.remove(at: indexPath.row)
        tblCartView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    /// Updates the UI based on whether the cart is empty or not.
    func updateEmptyCartUI() {
        let isCartEmpty = cartItems.isEmpty
        
        tblCartView.isHidden = isCartEmpty
        btnPlaceOrder.isHidden = isCartEmpty
        
        if isCartEmpty {
            lblEmptyCart.isHidden = false
            emptyCartAnimationView?.isHidden = false
            emptyCartAnimationView?.play()
        } else {
            lblEmptyCart.isHidden = true
            emptyCartAnimationView?.isHidden = true
            emptyCartAnimationView?.stop()
        }
    }
    /// Handles the back button tap event by navigating to the previous screen.
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backBtnTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [btnPlaceOrder])
        
        tblCartView.register(UINib(nibName: Main.CellIdentifiers.cartTableViewCell, bundle: nil), forCellReuseIdentifier: Main.CellIdentifiers.cartTableViewCell)
        // Setup reusable empty state
        let emptyState = EmptyStateHelper.setupEmptyState(
            in: view,
            animationName: "Empty Cart",   // name of your Lottie JSON
            message: "Your Cart is Empty!"
        )
        emptyCartAnimationView = emptyState.animationView
        lblEmptyCart = emptyState.label
        emptyCartAnimationView?.isHidden = false
        emptyCartAnimationView?.play()
    }
    
    /// Action triggered when the "Place Order" button is tapped.
    /// - Parameter sender: The object that initiated the action.
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        
        if !cartItems.isEmpty {
            let products: [ProductModel] = cartItems.map {
                ProductModel(
                    intId: Int($0.productId),
                    strProductName: $0.productName ?? "",
                    strProductDescription: "",
                    floatProductRating: 0,
                    doubleProductPrice: $0.price,
                    strProductImage: $0.image ?? "",
                    intProductQty: Int($0.quantity),
                    intTotalNumberOfRatings: 0,
                    objProductCategory: .All,
                    objProductType: .food
                )
            }
            
            CoreDataManager.shared.placeOrder(products: products, for: user)
            CoreDataManager.shared.clearCart(for: user)
            
            cartItems.removeAll()
            tblCartView.reloadData()
            updateEmptyCartUI()
            CartBadgeManager.shared.updateCartCount(to: 0)
            
            let alert = UIAlertController(title: "Order Placed",
                                          message: "Your order has been placed successfully!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Cart is Empty",
                                          message: "Please add items to your cart before placing an order.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
