//
//  EmptyStateHelper.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 02/09/25.
//

import Foundation
import UIKit
import Lottie

class EmptyStateHelper {
    
    /// Adds an empty state animation and label to a view controller
    /// - Parameters:
    ///   - parentView: The view where animation and label will be added
    ///   - animationName: The name of the Lottie JSON file
    ///   - message: The text message displayed below the animation
    ///   - size: Optional size for the animation (default: 200x200)
    /// - Returns: Tuple of animation view and label for controlling visibility
    @discardableResult
    static func setupEmptyState(
        in parentView: UIView,
        animationName: String,
        message: String,
        size: CGSize = CGSize(width: 200, height: 200)
    ) -> (animationView: LottieAnimationView, label: UILabel) {
        
        // Animation view
        let animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        parentView.addSubview(animationView)
        
        // Label
        let label = UILabel()
        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        parentView.addSubview(label)
        
        // Constraints
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: -50),
            animationView.widthAnchor.constraint(equalToConstant: size.width),
            animationView.heightAnchor.constraint(equalToConstant: size.height),
            
            label.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
        ])
        
        return (animationView, label)
    }
    
    static func show(animationView: LottieAnimationView, label: UILabel) {
        animationView.isHidden = false
        label.isHidden = false
        animationView.play()
    }
    
    /// Hides the empty state and stops animation
    static func hide(animationView: LottieAnimationView, label: UILabel) {
        animationView.stop()
        animationView.isHidden = true
        label.isHidden = true
    }
}
