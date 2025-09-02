import Foundation
import UIKit

/// Extension of `OffersViewController` to handle `UITableView` data source and delegate methods.
extension OffersViewController: UITableViewDataSource, UITableViewDelegate {
    
    /**
     Returns the number of rows for the given section in the table view.
     - Parameters:
     - tableView: The table view requesting this information.
     - section: The index number of the section.
     - Returns: The number of offers in the `arrOffer` array.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOffer.count
    }
    
    /**
     Configures and returns the cell for the given row at the specified index path.
     - Parameters:
     - tableView: The table view requesting the cell.
     - indexPath: The index path locating the row in the table view.
     - Returns: A configured `OffersTableViewCell` containing the offer data.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OffersTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: Main.CellIdentifiers.offersTableViewCell,
            for: indexPath
        ) as! OffersTableViewCell
        // Configure the cell with the offer at the current index.
        cell.offerConfigureCell(offer: arrOffer[indexPath.row])
        
        return cell
    }
}
