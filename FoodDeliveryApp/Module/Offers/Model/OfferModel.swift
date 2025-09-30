import Foundation

/// `OfferModel` represents a food or café offer in the app.
class OfferModel: NSObject {
    
    var imgOffer: String?
    var strOfferTitle: String?
    var intRating: Float?
    var intRater: Int?
    var strCafeName: String?
    var strFoodVariety: String?
    
    /**
     Initializes a new `OfferModel` instance.
     - Parameters:
     - imgOffer: Image name for the offer (optional).
     - strOfferTitle: Title of the offer (optional).
     - intRating: Rating of the café/offer (optional).
     - intRater: Number of raters (optional).
     - strCafeName: Name of the café (optional).
     - strFoodVariety: Type of food offered (optional).
     */
    init(imgOffer: String? = nil, strOfferTitle: String? = nil, intRating: Float? = nil, intRater: Int? = nil, strCafeName: String? = nil, strFoodVariety: String? = nil) {
        self.imgOffer = imgOffer
        self.strOfferTitle = strOfferTitle
        self.intRating = intRating
        self.intRater = intRater
        self.strCafeName = strCafeName
        self.strFoodVariety = strFoodVariety
    }
    
    /**
     Returns a sample list of `OfferModel` instances for demonstration or testing purposes.
     - Returns: Array of `OfferModel` objects.
     */
    class func addOffers()-> [OfferModel] {
        return [
            OfferModel(imgOffer: Main.Images.offer1,
                       strOfferTitle: Main.offer.offerTitle1,
                       intRating: 4.9,
                       intRater: 124,
                       strCafeName: Main.offer.offersCafeType,
                       strFoodVariety: Main.offer.offersFoodType),
            OfferModel(imgOffer: Main.Images.offer2,
                       strOfferTitle: Main.offer.offerTitle2,
                       intRating: 4.9,
                       intRater: 124,
                       strCafeName: Main.offer.offersCafeType,
                       strFoodVariety: Main.offer.offersFoodType),
            OfferModel(imgOffer: Main.Images.offer3,
                       strOfferTitle: Main.offer.offerTitle3,
                       intRating: 4.9,
                       intRater: 124,
                       strCafeName: Main.offer.offersCafeType,
                       strFoodVariety: Main.offer.offersFoodType)
        ]
    }
}
