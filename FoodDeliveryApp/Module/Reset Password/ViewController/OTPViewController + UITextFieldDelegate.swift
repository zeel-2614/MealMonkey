import Foundation
import UIKit

// MARK: - UITextFieldDelegate Methods for OTP Input
extension OTPViewController: UITextFieldDelegate {
    
    // Handles character input, movement between OTP fields, and backspace logic
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Allow only numeric input (0-9)
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Prevent pasting multiple characters at once
        if string.count > 1 {
            return false
        }
        
        // If a digit is entered
        if string.count == 1 {
            textField.text = string  // Replace current text with new digit
            
            // Move to next text field automatically
            switch textField {
            case txtFirstDigit:
                txtSecondDigit.becomeFirstResponder()
            case txtSecondDigit:
                txtThirdDigit.becomeFirstResponder()
            case txtThirdDigit:
                txtFourthDigit.becomeFirstResponder()
            case txtFourthDigit:
                txtFourthDigit.resignFirstResponder() // Last digit entered
            default:
                break
            }
            return false // We already set the text manually
        }
        
        // If backspace is pressed
        else if string.isEmpty {
            switch textField {
            case txtFourthDigit:
                txtThirdDigit.becomeFirstResponder()
            case txtThirdDigit:
                txtSecondDigit.becomeFirstResponder()
            case txtSecondDigit:
                txtFirstDigit.becomeFirstResponder()
            default:
                break
            }
            textField.text = "" // Clear the current text field
            return false
        }
        return true
    }
}
