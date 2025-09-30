import Foundation

/// A model representing various text-based informational data for sections like About, Notifications, and Inbox.
class AboutModel {
    
    /// The main text content.
    var strText: String?
    
    /// The time or relative time zone information (mainly used in notifications).
    var strTimezone: String?
    
    /// The right-side text (e.g., date in inbox messages).
    var strRightSideText: String?
    
    /// Additional text content (e.g., message body in inbox).
    var strText2: String?
    
    /// Initializes a new `AboutModel` instance.
    ///
    /// - Parameters:
    ///   - strText: The main text content.
    ///   - strTimezone: The time or relative time zone string.
    ///   - strRightSideText: Text displayed on the right side, often a date.
    ///   - strText2: Additional descriptive text.
    init(
        strText: String? = nil,
        strTimezone: String? = nil,
        strRightSideText: String? = nil,
        strText2: String? = nil
    ) {
        self.strText = strText
        self.strTimezone = strTimezone
        self.strRightSideText = strRightSideText
        self.strText2 = strText2
    }
    
    /// Provides predefined "About" section data.
    ///
    /// - Returns: An array of `AboutModel` containing about page content.
    class func addAboutData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.aboutUsModel.strText1),
            AboutModel(strText: Main.aboutUsModel.strText2),
            AboutModel(strText: Main.aboutUsModel.strText3),
            AboutModel(strText: Main.aboutUsModel.strText4),
            AboutModel(strText: Main.aboutUsModel.strText5),
            AboutModel(strText: Main.aboutUsModel.strText6),
            AboutModel(strText: Main.aboutUsModel.strText7)
        ]
    }
    
    /// Provides predefined notification data.
    ///
    /// - Returns: An array of `AboutModel` representing recent notifications with timestamps.
    class func addNotificationData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.notificationModel.orderPlacedTitle,
                       strTimezone: Main.notificationModel.orderPlacedSubTitle),
            AboutModel(strText: Main.notificationModel.paymentConfirmedTitle,
                       strTimezone: Main.notificationModel.paymentConfirmedSubTitle),
            AboutModel(strText: Main.notificationModel.foodPreparedTitle,
                       strTimezone: Main.notificationModel.foodPreparedSubTitle),
            AboutModel(strText: Main.notificationModel.agentAssignedTitle,
                       strTimezone: Main.notificationModel.agentAssignedSubTitle),
            AboutModel(strText: Main.notificationModel.orderOnWayTitle,
                       strTimezone: Main.notificationModel.orderOnWaySubTitle),
            AboutModel(strText: Main.notificationModel.discountTitle,
                       strTimezone: Main.notificationModel.discountSubTitle),
            AboutModel(strText: Main.notificationModel.appUpdateTitle,
                       strTimezone: Main.notificationModel.appUpdateSubTitle),
            AboutModel(strText: Main.notificationModel.referFriendTitle,
                       strTimezone: Main.notificationModel.referFriendSubTitle),
            AboutModel(strText: Main.notificationModel.limitedDealTitle,
                       strTimezone: Main.notificationModel.limitedDealSubTitle),
            AboutModel(strText: Main.notificationModel.deliveryDoneTitle,
                       strTimezone: Main.notificationModel.deliveryDoneSubTitle),
            AboutModel(strText: Main.notificationModel.rateMealTitle,
                       strTimezone: Main.notificationModel.rateMealSubTitle),
            AboutModel(strText: Main.notificationModel.weekendOfferTitle,
                       strTimezone: Main.notificationModel.weekendOfferSubTitle),
            AboutModel(strText: Main.notificationModel.freeDeliveryTitle,
                       strTimezone: Main.notificationModel.freeDeliverySubTitle),
            AboutModel(strText: Main.notificationModel.thanksTitle,
                       strTimezone: Main.notificationModel.thanksSubTitle),
            AboutModel(strText: Main.notificationModel.newRestaurantsTitle,
                       strTimezone: Main.notificationModel.newRestaurantsSubTitle)
        ]
    }
    
    /// Provides predefined inbox message data.
    ///
    /// - Returns: An array of `AboutModel` representing inbox messages with dates and descriptions.
    class func addInboxData() -> [AboutModel] {
        return [
            AboutModel(strText: Main.inboxModel.promotionsTitle,
                       strRightSideText: Main.inboxModel.promotionsSubTitle,
                       strText2: Main.inboxModel.promotionsDescription),
            AboutModel(strText: Main.inboxModel.orderUpdateTitle,
                       strRightSideText: Main.inboxModel.orderUpdateSubTitle,
                       strText2: Main.inboxModel.orderUpdateDescription),
            AboutModel(strText: Main.inboxModel.deliveryRemindersTitle,
                       strRightSideText: Main.inboxModel.deliveryRemindersSubTitle,
                       strText2: Main.inboxModel.deliveryRemindersDescription),
            AboutModel(strText: Main.inboxModel.welcomeTitle,
                       strRightSideText: Main.inboxModel.welcomeSubTitle,
                       strText2: Main.inboxModel.welcomeDescription),
            AboutModel(strText: Main.inboxModel.experienceTitle,
                       strRightSideText: Main.inboxModel.experienceSubTitle,
                       strText2: Main.inboxModel.experienceDescription),
            AboutModel(strText: Main.inboxModel.flashSaleTitle,
                       strRightSideText: Main.inboxModel.flashSaleSubTitle,
                       strText2: Main.inboxModel.flashDescription),
            AboutModel(strText: Main.inboxModel.newRestaurantsTitle,
                       strRightSideText: Main.inboxModel.newRestaurantsSubTitle,
                       strText2: Main.inboxModel.newRestaurantsDescription),
            AboutModel(strText: Main.inboxModel.referEarnTitle,
                       strRightSideText: Main.inboxModel.referEarnSubTitle,
                       strText2: Main.inboxModel.referEarnDescription),
            AboutModel(strText: Main.inboxModel.weekendSpecialTitle,
                       strRightSideText: Main.inboxModel.weekendSpecialSubTitle,
                       strText2: Main.inboxModel.weekendSpecialDescription),
            AboutModel(strText: Main.inboxModel.tipsTitle,
                       strRightSideText: Main.inboxModel.tipsSubTitle,
                       strText2: Main.inboxModel.tipsDescription),
            AboutModel(strText: Main.inboxModel.orderCancelTitle,
                       strRightSideText: Main.inboxModel.orderCancelSubTitle,
                       strText2: Main.inboxModel.orderCancelDescription),
            AboutModel(strText: Main.inboxModel.loyaltyProgramTitle,
                       strRightSideText: Main.inboxModel.loyaltyProgramSubTitle,
                       strText2: Main.inboxModel.loyaltyProgramDescription),
            AboutModel(strText: Main.inboxModel.securityUpdateTitle,
                       strRightSideText: Main.inboxModel.securityUpdateSubTitle,
                       strText2: Main.inboxModel.securityUpdateDescription),
            AboutModel(strText: Main.inboxModel.accountVerifiedTitle,
                       strRightSideText: Main.inboxModel.accountVerifiedSubTitle,
                       strText2: Main.inboxModel.accountVerifiedDescription),
            AboutModel(strText: Main.inboxModel.limitedDealTitle,
                       strRightSideText: Main.inboxModel.limitedDealSubTitle,
                       strText2: Main.inboxModel.limitedDealDescription)
        ]
    }
}
