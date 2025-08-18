import UIKit

/// Extension for `CartViewController` to conform to `UITableViewDelegate` and `UITableViewDataSource` protocols.
/// Handles the display and interaction with the cart's table view.
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of rows (cart items) to be displayed in the table view.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The index number of the section.
    /// - Returns: The number of rows in the section, equal to the count of cart items.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    /// Creates and configures the cell for a given row in the cart table view.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A configured `CartTableViewCell` displaying the product information.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable cart cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        
        // Retrieve product for the current row
        let product = cartItems[indexPath.row]
        
        // Configure cell with product details
        cell.configure(with: product)
        
        // Handle product deletion when delete action is triggered
        cell.onDelete = { [weak self] in
            guard let self = self,
                  let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
            
            // Remove product from cart
            appDelegate.arrCart.remove(at: indexPath.row)
            
            // Convert updated cart to dictionary array and save it
            let cartDictArray = appDelegate.arrCart.map { productToDict($0) }
            saveCartToUserDefaults(cartArray: cartDictArray)
            
            // Reload table view to reflect changes
            self.tblCartView.reloadData()
        }
        return cell
    }
}
