
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
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setLeftAlignedTitle("Cart Page")
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .gray, textField: [btnPlaceOrder])
        
        tblCartView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")

    }
    
    @IBAction func btnPlaceOrderClick(_ sender: Any) {
        
    }
}
