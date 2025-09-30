import Foundation
import UIKit

// MARK: - UITableViewDelegate & UITableViewDataSource for DessertsViewController
extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Returns the number of rows to display in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    // Configures and returns a cell for a specific index path.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell of type DessertsTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.dessertsTableViewCell, for: indexPath) as! DessertsTableViewCell
        cell.selectionStyle = .none // Disable default selection highlight
        // Configure the cell with product data
        cell.dessertConfigureCell(dessert: filteredProducts[indexPath.row])
        cell.applyTheme()
        return cell
    }
    
    // Handles what happens when a row is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let productVC = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.productDetailsViewController
        ) as? ProductDetailViewController {
            // Pass the selected product to the detail view controller
            let selectedProduct = filteredProducts[indexPath.row]
            productVC.selectedProduct = selectedProduct
            RecentItemsHelper.shared.addProduct(selectedProduct)
            // Navigate to the product detail screen
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
}
