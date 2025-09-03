import Foundation
import UIKit

/// Extension for `CheckoutViewController` to handle payment options,
/// table view data population, and text field validations.
extension CheckoutViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    /// Determines the number of rows in the table view.
    /// - Parameters:
    ///   - tableView: The table view requesting this information.
    ///   - section: The index number of the section.
    /// - Returns: The total number of rows for the payment methods list,
    ///   which includes 1 cash-on-delivery option, all saved cards, and 1 Gmail option.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + arrCards.count + 1
    }
    
    /// Configures and returns the cell for the given index path.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path locating the row in the table view.
    /// - Returns: A configured table view cell based on the payment method type.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // First row: Cash on Delivery option
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Main.CellIdentifiers.cashOnDeliveryTableViewCell,
                for: indexPath
            ) as! CashOnDeliveryTableViewCell
            
            cell.btnSelect.setImage(UIImage(systemName: selectedPaymentIndex == indexPath.row ? Main.Images.btnSelect : Main.Images.btnSelectState), for: .normal)
            return cell
        }
        
        // Middle rows: Saved Visa cards
        if indexPath.row > 0 && indexPath.row <= arrCards.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Main.CellIdentifiers.visaTableViewCell,
                for: indexPath
            ) as! VisaTableViewCell
            
            let cardIndex = indexPath.row - 1
            let fullCardNumber = arrCards[cardIndex]
            cell.lblCardNo.text = maskedCardNumber(fullCardNumber)
            cell.btnSelect.setImage(UIImage(systemName: selectedPaymentIndex == indexPath.row ? Main.Images.btnSelect : Main.Images.btnSelectState), for: .normal)
            return cell
        }
        
        // Last row: Gmail option
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Main.CellIdentifiers.gmailTableViewCell,
            for: indexPath
        ) as! GmailTableViewCell
        
        cell.btnSelect.setImage(UIImage(systemName: selectedPaymentIndex == indexPath.row ? Main.Images.btnSelect : Main.Images.btnSelectState), for: .normal)
        return cell
    }
    
    /// Masks a card number except for the last four digits.
    /// - Parameter number: The original card number.
    /// - Returns: The masked card number in groups of four characters.
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
    
    /// Validates and restricts user input for payment-related text fields.
    /// - Parameters:
    ///   - textField: The text field whose text is being changed.
    ///   - range: The range of characters to be replaced.
    ///   - string: The replacement string.
    /// - Returns: `true` if the change should be allowed; otherwise, `false`.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtCardNumber {
            return newText.count <= 16 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        if textField == txtExpiryMonth || textField == txtExpiryYear {
            return newText.count <= 2 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        if textField == txtSecurityCode {
            return newText.count <= 3 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        }
        return true
    }
    
    /// Handles selection of a payment method row.
    /// - Parameters:
    ///   - tableView: The table view that called this method.
    ///   - indexPath: The index path of the selected row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tableView.reloadData()
    }
    
    /// Handles the Return key action for text fields, navigating between fields.
    /// - Parameter textField: The text field where the Return key was pressed.
    /// - Returns: `true` to process the Return key press.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtCardNumber:
            txtExpiryMonth.becomeFirstResponder()
        case txtExpiryMonth:
            txtExpiryYear.becomeFirstResponder()
        case txtExpiryYear:
            txtSecurityCode.becomeFirstResponder()
        case txtSecurityCode:
            txtFirstName.becomeFirstResponder()
        case txtFirstName:
            txtLastName.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
