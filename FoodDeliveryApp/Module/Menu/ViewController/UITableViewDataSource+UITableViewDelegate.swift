import Foundation
import UIKit

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(
            name: "MenuStoryboard",
            bundle: nil
        )
        
        switch indexPath.row {
            
        case 0:
            print("Food")
            if let foodvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                foodvc.selectedProductType = .food
                self.navigationController?.pushViewController(
                    foodvc,
                    animated: true
                )
            }
        case 1:
            print("Beverages")
            
            if let beveragesvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                beveragesvc.selectedProductType = .Beverages
                
                self.navigationController?.pushViewController(
                    beveragesvc,
                    animated: true
                )
            }
        case 2:
            
            
            if let dessertvc = storyboard.instantiateViewController(
                withIdentifier: "DessertsViewController"
            ) as? DessertsViewController {
                dessertvc.selectedProductType = .Desserts
                
                self.navigationController?.pushViewController(
                    dessertvc,
                    animated: true
                )
            }
            
        default:
            break
        }    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.configureCell(category: arrCategory[indexPath.row])
        return cell
    }
}
