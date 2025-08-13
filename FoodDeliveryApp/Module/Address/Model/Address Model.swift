//
//  Address Model.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 12/08/25.
//

import Foundation
import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class CustomLocationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? LocationAnnotation else { return }
            
            // Load custom bubble view from XIB or build programmatically
            let bubble = UILabel()
            bubble.text = "\(customAnnotation.title ?? "")\n\(customAnnotation.subtitle ?? "")"
            bubble.numberOfLines = 0
            bubble.backgroundColor = .orange
            bubble.textColor = .white
            bubble.layer.cornerRadius = 8
            bubble.layer.masksToBounds = true
            bubble.font = .systemFont(ofSize: 14)
            
            addSubview(bubble)
            // Adjust frame & position to match your design
        }
    }
}
