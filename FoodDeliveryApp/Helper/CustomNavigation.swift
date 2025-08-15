import Foundation
import UIKit

extension UIViewController {
    
    func setLeftAlignedTitleWithBack(
        _ title: String,
        font: UIFont = .systemFont(ofSize: 29),
        textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary,
        target: Any?,
        action: Selector
    ) {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = textColor
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        titleLabel.isUserInteractionEnabled = true
        
        // Add tap gesture to title label
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        titleLabel.addGestureRecognizer(tapGesture)
        
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        let leftItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    
    func setLeftAlignedTitle(_ title: String, font: UIFont = .systemFont(ofSize: 29), textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func setCartButton(target: Any?, action: Selector, tintColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        let cartButton = UIBarButtonItem(image: cartImage, style: .plain, target: target, action: action)
        cartButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItem = cartButton
    }
}
