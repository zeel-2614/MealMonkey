
import UIKit

/// A view controller responsible for displaying and managing the user's cart.
class CartViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var lblEmptyCart: UILabel!
    @IBOutlet weak var tblCartView: UITableView!
    
    /// Computed property that retrieves the current cart items from the AppDelegate.
    var cartItems: [ProductModel] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrCart ?? []
    }
    
    /// Called when the view is about to appear on the screen.
    /// - Parameter animated: A Boolean value indicating whether the appearance is animated.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEmptyCartUI()
        tblCartView.reloadData()
    }
    
    /// Updates the UI based on whether the cart is empty or not.
    private func updateEmptyCartUI() {
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
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            // Load saved cart
            let savedCartArray = loadCartFromUserDefaults()
            appDelegate.arrCart = savedCartArray.map { dictToProduct($0) }
            
            // Load saved orders (THIS WAS MISSING)
            let savedOrders = loadOrdersFromUserDefaults()
            appDelegate.arrOrders = savedOrders
        }
    }
    
    /// Action triggered when the "Place Order" button is tapped.
    /// - Parameter sender: The object that initiated the action.
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if !appDelegate.arrCart.isEmpty {
            // Save the current cart as a new order
            appDelegate.arrOrders.append(appDelegate.arrCart)
            
            // Save orders using helper function from helpers file
            saveOrdersToUserDefaults(appDelegate.arrOrders)
            
            // Clear cart
            appDelegate.arrCart.removeAll()
            saveCartToUserDefaults(cartArray: [])
            
            updateEmptyCartUI()
            tblCartView.reloadData()
            
            // Show success alert
            let alert = UIAlertController(title: "Order Placed",
                                          message: "Your order has been placed successfully!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.tblCartView.reloadData()
            }))
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
