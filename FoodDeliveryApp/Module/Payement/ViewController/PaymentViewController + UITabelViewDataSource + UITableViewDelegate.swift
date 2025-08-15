import Foundation
import UIKit

extension PaymentViewController: UITableViewDataSource, UITableViewDelegate, CardDetailsCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        cell.lblCardNumber.text = maskedCardNumber(arrCards[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func saveCardsToDefaults() {
        UserDefaults.standard.set(arrCards, forKey: "savedCards")
    }
    
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
    
    func didTapDeleteButton(in cell: CardTableViewCell) {
        if let indexPath = tblCardDetails.indexPath(for: cell) {
            arrCards.remove(at: indexPath.row)
            saveCardsToDefaults()
            tblCardDetails.reloadData()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtCardNumber {
            return newText.count <= 16 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        if textField == txtExpiryMonth || textField == txtExpiryYear {
            return newText.count <= 2 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        return true
    }
    
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
