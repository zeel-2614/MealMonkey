import Foundation
import UIKit

/// Extension to handle UITableView data source and delegate methods for `AboutUsViewController`.
extension AboutUsViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Returns the number of rows for the given section.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The index of the section.
    /// - Returns: The total number of rows in the section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrent.count
    }
    
    /// Configures and returns the cell for a given index path.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path specifying the location of the cell.
    /// - Returns: A fully configured `AboutUsTableViewCell`.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AboutUsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.aboutUsTableViewCell, for: indexPath) as! AboutUsTableViewCell
        
        // Configure cell based on the current page type
        switch objPageType {
        case .AboutUs:
            cell.configureCellAboutUs(details: arrCurrent[indexPath.row])
        case .Notification:
            cell.configureCellNotifications(details: arrCurrent[indexPath.row])
        case .Inbox:
            cell.configureCellInbox(details: arrCurrent[indexPath.row])
            
        default:
            break
        }
        return cell
    }
}
