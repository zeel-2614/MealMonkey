
import UIKit

/// A view controller responsible for displaying and managing the user's cart.
class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var lblEmptyCart: UILabel!
    @IBOutlet weak var tblCartView: UITableView!
    
    /// Computed property that retrieves the current cart items from the AppDelegate.
    // Replace computed property with a stored property
    var cartItems: [CartItems] = []
    
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
        lblEmptyCart.isHidden = !isCartEmpty
        tblCartView.isHidden = isCartEmpty
        btnPlaceOrder.isHidden = isCartEmpty
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
        
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    
    /// Action triggered when the "Place Order" button is tapped.
    /// - Parameter sender: The object that initiated the action.
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        
        if !cartItems.isEmpty {
            // Convert CartItems to ProductModel
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
            
            // Place order using ProductModel
            CoreDataManager.shared.placeOrder(products: products, for: user)
            
            // Clear cart in Core Data
            CoreDataManager.shared.clearCart(for: user)
            
            // Clear local array and update UI
            cartItems.removeAll()
            tblCartView.reloadData()
            updateEmptyCartUI()
            
            // Update cart badge
            CartBadgeManager.shared.updateCartCount(to: 0)
            
            // Show success alert
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
