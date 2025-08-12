import Foundation
import UIKit

extension DessertsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell", for: indexPath) as! DessertsTableViewCell
        cell.selectionStyle = .none
        cell.dessertConfigureCell(dessert: arrProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let productVC = storyboard.instantiateViewController(
            withIdentifier: "ProductDetailViewController"
        ) as? ProductDetailViewController {
            productVC.selectedProduct = arrProducts[indexPath.row]
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
}
