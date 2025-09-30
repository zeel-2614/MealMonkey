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
                title: Main.nextPage.nextPage1,
                subTitle: Main.nextPage.nextPage1Description),
        Feature(imageName: Main.Images.image2,
                title: Main.nextPage.nextPage2,
                subTitle: Main.nextPage.nextPage2Description),
        Feature(imageName: Main.Images.image3,
                title: Main.nextPage.nextPage3,
                subTitle: Main.nextPage.nextPage3Description)
    ]
}
