
import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var tblCartView: UITableView!
    
    var cartItems: [ProductModel] {
        return (UIApplication.shared.delegate as? AppDelegate)?.arrCart ?? []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the data every time the view appears to get the latest cart items.
        tblCartView.reloadData()
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Cart", target: self, action: #selector(backBtnTapped))
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [btnPlaceOrder])
        
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
    }
    
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if appDelegate.arrCart.isEmpty {
            let alert = UIAlertController(title: "Empty Cart", message: "Please add items before placing an order.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Get the next order number
        let lastOrderNumber = appDelegate.arrOrders.compactMap { $0.orderNumber }.max() ?? 0
        let newOrderNumber = lastOrderNumber + 1
        
        // Assign order number to all products in the cart
        for product in appDelegate.arrCart {
            product.orderNumber = newOrderNumber
        }
        
        // Move to orders
        appDelegate.arrOrders.append(contentsOf: appDelegate.arrCart)
        
        // Clear cart
        appDelegate.arrCart.removeAll()
        tblCartView.reloadData()
        
        // Show alert
        let alert = UIAlertController(title: "Order Placed", message: "Your order #\(newOrderNumber) has been placed successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
