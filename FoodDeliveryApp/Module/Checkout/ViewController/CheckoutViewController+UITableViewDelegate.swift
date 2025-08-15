import Foundation
import UIKit

extension CheckoutViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + arrCards.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "CashOnDeliveryTableViewCell",
                for: indexPath
            ) as! CashOnDeliveryTableViewCell
            
            cell.btnSelect.setImage(UIImage(systemName: selectedPaymentIndex == indexPath.row ? "circle.inset.filled" : "circle"), for: .normal)
            return cell
        }
        
        if indexPath.row > 0 && indexPath.row <= arrCards.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "VisaTableViewCell",
                for: indexPath
            ) as! VisaTableViewCell
            
            let cardIndex = indexPath.row - 1
            let fullCardNumber = arrCards[cardIndex]
            cell.lblCardNo.text = maskedCardNumber(fullCardNumber)
            cell.btnSelect.setImage(UIImage(systemName: selectedPaymentIndex == indexPath.row ? "circle.inset.filled" : "circle"), for: .normal)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "GmailTableViewCell",
            for: indexPath
        ) as! GmailTableViewCell
        
        cell.btnSelect.setImage(UIImage(systemName: selectedPaymentIndex == indexPath.row ? "circle.inset.filled" : "circle"), for: .normal)
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaymentIndex = indexPath.row
        tableView.reloadData()
    }
    
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

