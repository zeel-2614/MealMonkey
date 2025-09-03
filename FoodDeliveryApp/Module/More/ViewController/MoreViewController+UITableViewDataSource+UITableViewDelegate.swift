import Foundation
import UIKit

/// Extension to handle table view delegate methods for `MoreViewController`.
extension MoreViewController: UITableViewDelegate {
    
    /// Called when a user taps a row in the table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            // Navigate to Payment Details screen.
            let storyboard = UIStoryboard(name: Main.Storyboards.moreStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.paymentViewController) as? PaymentViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        case 1:
            // Navigate to My Orders screen.
            let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.orderListViewController) as? OrderListViewController {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        case 2:
            // Navigate to Notifications screen via AboutUsViewController with `.Notification` type.
            let storyboard = UIStoryboard(name: Main.Storyboards.moreStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.aboutUsViewController) as? AboutUsViewController {
                VC.objPageType = .Notification
                self.navigationController?.pushViewController(VC, animated: true)
            }
        case 3:
            // Navigate to Inbox screen via AboutUsViewController with `.Inbox` type.
            let storyboard = UIStoryboard(name: Main.Storyboards.moreStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.aboutUsViewController) as? AboutUsViewController {
                VC.objPageType = .Inbox
                self.navigationController?.pushViewController(VC, animated: true)
            }
        case 4:
            // Navigate to About Us screen via AboutUsViewController with `.AboutUs` type.
            let storyboard = UIStoryboard(name: Main.Storyboards.moreStoryBoard, bundle: nil)
            if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.aboutUsViewController) as? AboutUsViewController {
                VC.objPageType = .AboutUs
                self.navigationController?.pushViewController(VC, animated: true)
            }
        case 5:
            // Navigate to Wishlist screen.
            let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.wishListViewController) as? WishlistViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
        default:
            break
        }
    }
}

/// Extension to handle table view data source methods for `MoreViewController`.
extension MoreViewController: UITableViewDataSource {
    
    /// Returns the number of rows for the table view section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMore.count
    }
    
    /// Configures and returns a cell for a given row in the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.moreTableViewCell, for: indexPath) as! MoreTableViewCell
        cell.configureMenuCell(more: arrMore[indexPath.row])
        return cell
    }
}

/// Enum defining page types used by AboutUsViewController.
enum PageType {
    case PayMent
    case MyOrders
    case Notification
    case Inbox
    case AboutUs
    case WishList
}
