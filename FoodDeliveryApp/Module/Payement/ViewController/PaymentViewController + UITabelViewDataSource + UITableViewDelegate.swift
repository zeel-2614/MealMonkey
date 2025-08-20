import Foundation
import UIKit

// MARK: - TableView DataSource, Delegate & CardDetailsCellDelegate Implementation
extension PaymentViewController: UITableViewDataSource, UITableViewDelegate, CardDetailsCellDelegate {
    
    // Number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCards.count
    }
    
    // Configure each card cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        cell.lblCardNumber.text = maskedCardNumber(arrCards[indexPath.row]) // Show masked card number
        cell.delegate = self // Set delegate to handle delete button tap
        return cell
    }
    
    // Save current cards to UserDefaults
    func saveCardsToDefaults() {
        UserDefaults.standard.set(arrCards, forKey: "savedCards")
    }
    
    // Mask card number, leaving only the last 4 digits visible and formatting with spaces
    func maskedCardNumber(_ number: String) -> String {
        let masked = String(repeating: "*", count: max(0, number.count - 4)) + number.suffix(4)
        var result = ""
        for (index, char) in masked.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(char)
        }
        return result
    }
    
    // Handle delete button tap from CardTableViewCell
    func didTapDeleteButton(in cell: CardTableViewCell) {
        if let indexPath = tblCardDetails.indexPath(for: cell) {
            arrCards.remove(at: indexPath.row) // Remove the card from the list
            saveCardsToDefaults() // Save updated list
            tblCardDetails.reloadData() // Refresh table view
        }
    }
    
    // Restrict text field inputs for card details
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtCardNumber {
            // Allow only digits and max length 16
            return newText.count <= 16 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        if textField == txtExpiryMonth || textField == txtExpiryYear {
            // Allow only digits and max length 2
            return newText.count <= 2 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        return true
    }
    
    // Handle return key navigation between text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            
        case txtCardNumber:
            txtCardNumber.resignFirstResponder()
            txtExpiryMonth.becomeFirstResponder()
            
        case txtExpiryMonth:
            txtExpiryMonth.resignFirstResponder()
            txtExpiryYear.becomeFirstResponder()
            
        case txtExpiryYear:
            txtExpiryYear.resignFirstResponder()
            txtSecurityCode.becomeFirstResponder()
            
        case txtSecurityCode:
            txtSecurityCode.resignFirstResponder()
            txtFirstName.becomeFirstResponder()
            
        case txtFirstName:
            txtFirstName.resignFirstResponder()
            txtLastName.becomeFirstResponder()
            
        case txtLastName:
            txtLastName.resignFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
