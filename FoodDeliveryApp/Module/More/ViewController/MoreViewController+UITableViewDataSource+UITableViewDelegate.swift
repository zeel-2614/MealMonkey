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
        
        let item = arrMore[indexPath.row]
        if item.intTag == 6 {  // Language cell
            showLanguagePicker()
        }
        
        let themesitem = arrMore[indexPath.row]
        if themesitem.intTag == 7 {  // Language cell
            showThemePicker()
        }
        
        func showLanguagePicker() {
            let alert = UIAlertController(title: "Select Language", message: "\n\n\n\n\n\n", preferredStyle: .alert)
            
            let picker = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
            picker.tag = 1  // Theme picker
            picker.dataSource = self
            picker.delegate = self
            
            let current = LanguageManager.shared.currentLanguage
            if let index = LanguageManager.Language.allCases.firstIndex(of: current) {
                picker.selectRow(index, inComponent: 0, animated: false)
            }
            
            alert.view.addSubview(picker)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                let selectedIndex = picker.selectedRow(inComponent: 0)
                let selectedLang = LanguageManager.Language.allCases[selectedIndex]
                LanguageManager.shared.setLanguage(selectedLang)
                LanguageManager.shared.reloadAppInterface()
            }))
            
            present(alert, animated: true, completion: nil)
        }
        
        func showThemePicker() {
            let alert = UIAlertController(title: "Select Theme", message: "\n\n\n\n\n\n", preferredStyle: .alert)
            
            let picker = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
            picker.tag = 2  // Theme picker
            picker.dataSource = self
            picker.delegate = self

            // Preselect current theme
            if let currentIndex = AppTheme.allCases.firstIndex(of: ThemeManager.shared.currentThemeEnum) {
                picker.selectRow(currentIndex, inComponent: 0, animated: false)
            }

            alert.view.addSubview(picker)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                let selectedIndex = picker.selectedRow(inComponent: 0)
                let selectedTheme = AppTheme.allCases[selectedIndex]
                
                // Apply theme immediately
                ThemeManager.shared.applyTheme(selectedTheme)
                
                // Apply theme to this view controller
                self.applyTheme()
                
                // If you want to update navigation bar
                self.navigationController?.navigationBar.barTintColor = ThemeManager.shared.currentTheme.navigationBarColor
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: ThemeManager.shared.currentTheme.labelTextColor]
                
                // Reload table to apply theme on cells
                self.tblMenu.reloadData()
            }))

            present(alert, animated: true)
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
        cell.applyTheme()
        return cell
    }
}

extension MoreViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 { // Language picker
            return LanguageManager.Language.allCases.count
        } else { // Theme picker
            return AppTheme.allCases.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 { // Language picker
            return LanguageManager.Language.allCases[row].displayName
        } else { // Theme picker
            return AppTheme.allCases[row].rawValue.capitalized
        }
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
