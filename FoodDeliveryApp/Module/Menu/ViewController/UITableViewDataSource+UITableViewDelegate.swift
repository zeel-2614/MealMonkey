import Foundation
import UIKit

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
    /// Handles table view row selection.
    /// Navigates to the corresponding `DessertsViewController` with the correct product type.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        
        switch indexPath.row {
        case 0:
            // Navigate to Food category
            print("Food")
            if let foodvc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                foodvc.selectedProductType = .food
                self.navigationController?.pushViewController(foodvc, animated: true)
            }
            
        case 1:
            // Navigate to Beverages category
            print("Beverages")
            if let beveragesvc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                beveragesvc.selectedProductType = .Beverages
                self.navigationController?.pushViewController(beveragesvc, animated: true)
            }
            
        case 2:
            // Navigate to Desserts category
            if let dessertvc = storyboard.instantiateViewController(withIdentifier: "DessertsViewController") as? DessertsViewController {
                dessertvc.selectedProductType = .Desserts
                self.navigationController?.pushViewController(dessertvc, animated: true)
            }
            
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    /// Returns the number of rows (categories) to display in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    /// Configures and returns the table view cell for a specific row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        // Set transparent backgrounds
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        // Configure cell with category data
        cell.configureCell(category: arrCategory[indexPath.row])
        
        return cell
    }
}
