import Foundation
import UIKit

/// A model representing a feature displayed in the app's onboarding or feature list.
class Feature: NSObject{
    
    let imageName: String
    let title: String
    let subTitle: String
    
    /// Initializes a `Feature` model.
    /// - Parameters:
    ///   - imageName: The name of the image asset.
    ///   - title: The title of the feature.
    ///   - subTitle: The subtitle or description of the feature.
    init(imageName: String, title: String, subTitle: String) {
        self.imageName = imageName
        self.title = title
        self.subTitle = subTitle
    }
    
    /// A predefined list of app features.
    static let features: [Feature] = [
        Feature(imageName: Main.Images.image1,
                title: "Find Food You Love",
                subTitle: "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"),
        Feature(imageName: Main.Images.image2,
                title: "Fast Delivery",
                subTitle: "Fast food delivery to your home, office wherever you are"),
        Feature(imageName: Main.Images.image3,
                title: "Live Tracking",
                subTitle: "Real time tracking of your food on the app once you placed the order")
    ]
}
