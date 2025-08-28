import Foundation
import UIKit

extension UIViewController {
    
    /// Sets a left-aligned navigation bar title with a back button.
    ///
    /// - Parameters:
    ///   - title: The text to display as the navigation bar title.
    ///   - font: The font to use for the title label. Defaults to system font size 29.
    ///   - textColor: The color of both the back button and the title label. Defaults to "NavigationColor" from asset catalog or `.labelPrimary`.
    ///   - target: The target object that responds to back button and title tap actions.
    ///   - action: The selector to call when the back button or title is tapped.
    func setLeftAlignedTitleWithBack(
        _ title: String,
        font: UIFont = .systemFont(ofSize: 29),
        textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary,
        target: Any?,
        action: Selector
    ) {
        // Create the back button with system chevron icon
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = textColor
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        // Create the title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        titleLabel.isUserInteractionEnabled = true
        
        // Add tap gesture to the title label to trigger the same action as back button
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        titleLabel.addGestureRecognizer(tapGesture)
        
        // Arrange back button and title label horizontally
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        // Assign stack view as left bar button item
        let leftItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    /// Sets a left-aligned navigation bar title without a back button.
    ///
    /// - Parameters:
    ///   - title: The text to display as the navigation bar title.
    ///   - font: The font to use for the title label. Defaults to system font size 29.
    ///   - textColor: The color of the title label. Defaults to "NavigationColor" from asset catalog or `.labelPrimary`.
    func setLeftAlignedTitle(
        _ title: String,
        font: UIFont = .systemFont(ofSize: 29),
        textColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary
    ) {
        // Create and configure the title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()
        
        // Assign the label as left bar button item
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    /// Sets a cart icon button on the right side of the navigation bar.
    ///
    /// - Parameters:
    ///   - target: The target object that responds to the cart button action.
    ///   - action: The selector to call when the cart button is tapped.
    ///   - tintColor: The tint color of the cart icon. Defaults to "NavigationColor" from asset catalog or `.labelPrimary`.
    func setCartButton(
        target: Any?,
        action: Selector,
        tintColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary
    ) {
        // Create cart icon image with template rendering
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        
        // Create bar button item with cart icon
        let cartButton = UIBarButtonItem(image: cartImage, style: .plain, target: target, action: action)
        cartButton.tintColor = tintColor
        
        // Assign the cart button as right bar button item
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    func setCartButtonWithBadge(
        target: Any?,
        action: Selector,
        tintColor: UIColor = UIColor(named: "NavigationColor") ?? .labelPrimary
    ) {
        let cartButton = UIButton(type: .custom)
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(.alwaysTemplate)
        cartButton.setImage(cartImage, for: .normal)
        cartButton.tintColor = tintColor
        cartButton.addTarget(target, action: action, for: .touchUpInside)
        cartButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        // Add badge label
        let badgeLabel = UILabel()
        badgeLabel.tag = 999 // Identifier for updates
        badgeLabel.frame = CGRect(x: 18, y: -5, width: 18, height: 18)
        badgeLabel.backgroundColor = .red
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 9
        badgeLabel.layer.masksToBounds = true
        badgeLabel.isHidden = true
        cartButton.addSubview(badgeLabel)
        
        // Add button to navigation bar
        let barButtonItem = UIBarButtonItem(customView: cartButton)
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        // Initialize badge value
        updateCartBadge()
        
        // Listen for updates
        NotificationCenter.default.addObserver(
            forName: .cartCountUpdated,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateCartBadge()
        }
    }

    private func updateCartBadge() {
        if let cartButton = self.navigationItem.rightBarButtonItem?.customView as? UIButton,
           let badgeLabel = cartButton.viewWithTag(999) as? UILabel {
            
            let count = CartBadgeManager.shared.cartCount
            badgeLabel.isHidden = count == 0
            badgeLabel.text = "\(count)"
        }
    }
}
