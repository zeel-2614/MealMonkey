//
//  Struct Class.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 29/08/25.
//

import Foundation

/**
 `Main` is a centralized structure containing various nested structures that store constants used throughout the app.
 
 These constants include:
 - **Cell Identifiers:** For table view and collection view cells.
 - **Image Names:** For assets used in the app.
 - **Storyboard Names:** For navigation and UI loading.
 - **View Controller Identifiers:** For instantiating view controllers.
 - **Models and Static Data:** Such as About Us text, notification messages, inbox messages, etc.
 - **Alert Messages:** For user-facing error or confirmation dialogs.
 - **Keys:** For UserDefaults and persistent storage keys.
 - **Animations:** Names and descriptions for Lottie or similar animations.
 
 Using this structure ensures consistent usage of strings across the project, reducing hard-coded string usage and improving maintainability.
 */
struct Main {
    // MARK: - Cell Identifiers
    struct CellIdentifiers {
        static let aboutUsTableViewCell = "AboutUsTableViewCell"
        static let cartTableViewCell = "CartTableViewCell"
        static let cashOnDeliveryTableViewCell = "CashOnDeliveryTableViewCell"
        static let gmailTableViewCell = "GmailTableViewCell"
        static let visaTableViewCell = "VisaTableViewCell"
        static let dessertsTableViewCell = "DessertsTableViewCell"
        static let homeTableViewCell = "HomeTableViewCell"
        static let homeCategoryCollectionViewCell = "HomeCategoryCollectionViewCell"
        static let popularCollectionViewCell = "PopularCollectionViewCell"
        static let mostPopularCollectionViewCell = "MostPopularCollectionViewCell"
        static let recentItemsCollectionViewCell = "RecentItemsCollectionViewCell"
        static let menuTableViewCell = "MenuTableViewCell"
        static let moreTableViewCell = "MoreTableViewCell"
        static let myOrderTableViewCell = "MyOrderTableViewCell"
        static let nextPageCollectionViewCell = "CollectionViewCellNextPageCollectionViewCell"
        static let offersTableViewCell = "OffersTableViewCell"
        static let orderListTableViewCell = "OrderListTableViewCell"
        static let cardTableViewCell = "CardTableViewCell"
        static let wishlistTableViewCell = "WishlistTableViewCell"
    }
    // MARK: - Image Asset Names
    struct Images {
        static let dessertsBackShade = "ic_desserts_back_shade"
        static let all = "ic_all"
        static let paneertikka = "ic_paneertikka"
        static let hakkanoodles = "ic_hakkanoodles"
        static let khamanDhokla = "Ic_Khaman_Dhokla"
        static let masalaDosa = "ic_masaladosa"
        static let margheritaPizza = "ic_cheese_burger"
        static let food = "ic_Food"
        static let beverages = "ic_Beverages"
        static let desserts = "ic_Desserts"
        static let paymentDetails = "ic_payment_details"
        static let myOrders = "ic_my_order"
        static let notification = "ic_notification"
        static let inbox = "ic_inbox"
        static let aboutUs = "ic_aboutus"
        static let wishlist = "ic_wishlist"
        static let languageImage = "ic_language"
        static let themeImage = "ic_theme"
        static let image1 = "ic_image1"
        static let image2 = "ic_image2"
        static let image3 = "ic_image3"
        static let offer1 = "ic_offer1"
        static let offer2 = "ic_offer2"
        static let offer3 = "ic_offer3"
        static let addressCustomPin = "ic_current_position"
        static let btnWishlist = "heart.fill"
        static let btnWishlistState = "heart"
        static let btnSelect = "circle.inset.filled"
        static let btnSelectState = "circle"
        static let btnPassword = "eye"
        static let btnPasswordVisible = "eye.slash"
        static let profileImage = "placeholderProfile"
        static let backButton = "chevron.backward"
    }
    // MARK: - Storyboard Names
    struct Storyboards {
        static let productStoryBoard = "ProductStoryboard"
        static let homeStoryBoard = "HomeStoryboard"
        static let menuStoryBoard = "MenuStoryboard"
        static let moreStoryBoard = "MoreStoryboard"
        static let userStoryBoard = "UserStoryboard"
        static let mainStoryBoard = "Main"
    }
    // MARK: - ViewControllers
    struct ViewControllers {
        static let cartViewController = "CartViewController"
        static let menuViewController = "MenuViewController"
        static let offersViewController = "OffersViewController"
        static let homeViewController = "HomeViewController"
        static let profileViewController = "ProfileViewController"
        static let moreViewController = "MoreViewController"
        static let dessertsViewController = "DessertsViewController"
        static let aboutUsViewController = "AboutUsViewController"
        static let paymentViewController = "PaymentViewController"
        static let myOrderViewController = "MyOrderViewController"
        static let checkoutViewController = "CheckoutViewController"
        static let addressViewController = "AddressViewController"
        static let orderListViewController = "OrderListViewController"
        static let wishListViewController = "WishlistViewController"
        static let productDetailsViewController = "ProductDetailViewController"
        static let loginViewController = "LoginViewController"
        static let signUpViewController = "SignUpViewController"
        static let forgetPasswordViewController = "ForgetPasswordViewController"
        static let newPasswordViewController = "NewPasswordViewController"
        static let nextPageViewController = "NextPageViewController"
        static let otpViewController = "OTPViewController"
        static let mainTabBarViewController = "MainTabViewController"
    }
    // MARK: - About Us Texts
    struct aboutUsModel {
        static var strText1: String { NSLocalizedString("aboutus_screen_inside_first_text", comment: "") }
        static var strText2: String { NSLocalizedString("aboutus_screen_inside_second_text", comment: "") }
        static var strText3: String { NSLocalizedString("aboutus_screen_inside_third_text", comment: "") }
        static var strText4: String { NSLocalizedString("aboutus_screen_inside_fourth_text", comment: "") }
        static var strText5: String { NSLocalizedString("aboutus_screen_inside_fifth_text", comment: "") }
        static var strText6: String { NSLocalizedString("aboutus_screen_inside_sixth_text", comment: "") }
        static var strText7: String { NSLocalizedString("aboutus_screen_inside_seventh_text", comment: "") }
    }
    // MARK: - Notification Data Model
    struct notificationModel {
        static var orderPlacedTitle: String { NSLocalizedString("notification_screen_inside_orderPlacedTitle", comment: "") }
        static var orderPlacedSubTitle: String { NSLocalizedString("notification_screen_inside_orderPlacedSubTitle", comment: "") }
        
        static var paymentConfirmedTitle: String { NSLocalizedString("notification_screen_inside_paymentConfirmedTitle", comment: "") }
        static var paymentConfirmedSubTitle: String { NSLocalizedString("notification_screen_inside_paymentConfirmedSubTitle", comment: "") }
        
        static var foodPreparedTitle: String { NSLocalizedString("notification_screen_inside_foodPreparedTitle", comment: "") }
        static var foodPreparedSubTitle: String { NSLocalizedString("notification_screen_inside_foodPreparedSubTitle", comment: "") }
        
        static var agentAssignedTitle: String { NSLocalizedString("notification_screen_inside_agentAssignedTitle", comment: "") }
        static var agentAssignedSubTitle: String { NSLocalizedString("notification_screen_inside_agentAssignedSubTitle", comment: "") }
        
        static var orderOnWayTitle: String { NSLocalizedString("notification_screen_inside_orderOnWayTitle", comment: "") }
        static var orderOnWaySubTitle: String { NSLocalizedString("notification_screen_inside_orderOnWaySubTitle", comment: "") }
        
        static var discountTitle: String { NSLocalizedString("notification_screen_inside_discountTitle", comment: "") }
        static var discountSubTitle: String { NSLocalizedString("notification_screen_inside_discountSubTitle", comment: "") }
        
        static var appUpdateTitle: String { NSLocalizedString("notification_screen_inside_appUpdateTitle", comment: "") }
        static var appUpdateSubTitle: String { NSLocalizedString("notification_screen_inside_appUpdateSubTitle", comment: "") }
        
        static var referFriendTitle: String { NSLocalizedString("notification_screen_inside_referFriendTitle", comment: "") }
        static var referFriendSubTitle: String { NSLocalizedString("notification_screen_inside_referFriendSubTitle", comment: "") }
        
        static var limitedDealTitle: String { NSLocalizedString("notification_screen_inside_limitedDealTitle", comment: "") }
        static var limitedDealSubTitle: String { NSLocalizedString("notification_screen_inside_limitedDealSubTitle", comment: "") }
        
        static var deliveryDoneTitle: String { NSLocalizedString("notification_screen_inside_deliveryDoneTitle", comment: "") }
        static var deliveryDoneSubTitle: String { NSLocalizedString("notification_screen_inside_deliveryDoneSubTitle", comment: "") }
        
        static var rateMealTitle: String { NSLocalizedString("notification_screen_inside_rateMealTitle", comment: "") }
        static var rateMealSubTitle: String { NSLocalizedString("notification_screen_inside_rateMealSubTitle", comment: "") }
        
        static var weekendOfferTitle: String { NSLocalizedString("notification_screen_inside_weekendOfferTitle", comment: "") }
        static var weekendOfferSubTitle: String { NSLocalizedString("notification_screen_inside_weekendOfferSubTitle", comment: "") }
        
        static var freeDeliveryTitle: String { NSLocalizedString("notification_screen_inside_freeDeliveryTitle", comment: "") }
        static var freeDeliverySubTitle: String { NSLocalizedString("notification_screen_inside_freeDeliverySubTitle", comment: "") }
        
        static var thanksTitle: String { NSLocalizedString("notification_screen_inside_thanksTitle", comment: "") }
        static var thanksSubTitle: String { NSLocalizedString("notification_screen_inside_thanksSubTitle", comment: "") }
        
        static var newRestaurantsTitle: String { NSLocalizedString("notification_screen_inside_newRestaurantsTitle", comment: "") }
        static var newRestaurantsSubTitle: String { NSLocalizedString("notification_screen_inside_newRestaurantsSubTitle", comment: "") }
    }
    // MARK: - Inbox Model Data
    struct inboxModel {
        static var promotionsTitle: String { NSLocalizedString("inbox_screen_inside_promotionsTitle", comment: "") }
        static var promotionsSubTitle: String { NSLocalizedString("inbox_screen_inside_promotionsSubTitle", comment: "") }
        static var promotionsDescription: String { NSLocalizedString("inbox_screen_inside_promotionsDescription", comment: "") }
        
        static var orderUpdateTitle: String { NSLocalizedString("inbox_screen_inside_orderUpdateTitle", comment: "") }
        static var orderUpdateSubTitle: String { NSLocalizedString("inbox_screen_inside_orderUpdateSubTitle", comment: "") }
        static var orderUpdateDescription: String { NSLocalizedString("inbox_screen_inside_orderUpdateDescription", comment: "") }
        
        static var deliveryRemindersTitle: String { NSLocalizedString("inbox_screen_inside_deliveryRemindersTitle", comment: "") }
        static var deliveryRemindersSubTitle: String { NSLocalizedString("inbox_screen_inside_deliveryRemindersSubTitle", comment: "") }
        static var deliveryRemindersDescription: String { NSLocalizedString("inbox_screen_inside_deliveryRemindersDescription", comment: "") }
        
        static var welcomeTitle: String { NSLocalizedString("inbox_screen_inside_welcomeTitle", comment: "") }
        static var welcomeSubTitle: String { NSLocalizedString("inbox_screen_inside_welcomeSubTitle", comment: "") }
        static var welcomeDescription: String { NSLocalizedString("inbox_screen_inside_welcomeDescription", comment: "") }
        
        static var experienceTitle: String { NSLocalizedString("inbox_screen_inside_experienceTitle", comment: "") }
        static var experienceSubTitle: String { NSLocalizedString("inbox_screen_inside_experienceSubTitle", comment: "") }
        static var experienceDescription: String { NSLocalizedString("inbox_screen_inside_experienceDescription", comment: "") }
        
        static var flashSaleTitle: String { NSLocalizedString("inbox_screen_inside_flashSaleTitle", comment: "") }
        static var flashSaleSubTitle: String { NSLocalizedString("inbox_screen_inside_flashSaleSubTitle", comment: "") }
        static var flashDescription: String { NSLocalizedString("inbox_screen_inside_flashSaleDescription", comment: "") }
        
        static var newRestaurantsTitle: String { NSLocalizedString("inbox_screen_inside_newRestaurantsTitle", comment: "") }
        static var newRestaurantsSubTitle: String { NSLocalizedString("inbox_screen_inside_newRestaurantsSubTitle", comment: "") }
        static var newRestaurantsDescription: String { NSLocalizedString("inbox_screen_inside_newRestaurantsDescription", comment: "") }
        
        static var referEarnTitle: String { NSLocalizedString("inbox_screen_inside_referEarnTitle", comment: "") }
        static var referEarnSubTitle: String { NSLocalizedString("inbox_screen_inside_referEarnSubTitle", comment: "") }
        static var referEarnDescription: String { NSLocalizedString("inbox_screen_inside_referEarnDescription", comment: "") }
        
        static var weekendSpecialTitle: String { NSLocalizedString("inbox_screen_inside_weekendSpecialTitle", comment: "") }
        static var weekendSpecialSubTitle: String { NSLocalizedString("inbox_screen_inside_weekendSpecialSubTitle", comment: "") }
        static var weekendSpecialDescription: String { NSLocalizedString("inbox_screen_inside_weekendSpecialDescription", comment: "") }
        
        static var tipsTitle: String { NSLocalizedString("inbox_screen_inside_tipsTitle", comment: "") }
        static var tipsSubTitle: String { NSLocalizedString("inbox_screen_inside_tipsSubTitle", comment: "") }
        static var tipsDescription: String { NSLocalizedString("inbox_screen_inside_tipsDescription", comment: "") }
        
        static var orderCancelTitle: String { NSLocalizedString("inbox_screen_inside_orderCancelTitle", comment: "") }
        static var orderCancelSubTitle: String { NSLocalizedString("inbox_screen_inside_orderCancelSubTitle", comment: "") }
        static var orderCancelDescription: String { NSLocalizedString("inbox_screen_inside_orderCancelDescription", comment: "") }
        
        static var loyaltyProgramTitle: String { NSLocalizedString("inbox_screen_inside_loyaltyProgramTitle", comment: "") }
        static var loyaltyProgramSubTitle: String { NSLocalizedString("inbox_screen_inside_loyaltyProgramSubTitle", comment: "") }
        static var loyaltyProgramDescription: String { NSLocalizedString("inbox_screen_inside_loyaltyProgramDescription", comment: "") }
        
        static var securityUpdateTitle: String { NSLocalizedString("inbox_screen_inside_securityUpdateTitle", comment: "") }
        static var securityUpdateSubTitle: String { NSLocalizedString("inbox_screen_inside_securityUpdateSubTitle", comment: "") }
        static var securityUpdateDescription: String { NSLocalizedString("inbox_screen_inside_securityUpdateDescription", comment: "") }
        
        static var accountVerifiedTitle: String { NSLocalizedString("inbox_screen_inside_accountVerifiedTitle", comment: "") }
        static var accountVerifiedSubTitle: String { NSLocalizedString("inbox_screen_inside_accountVerifiedSubTitle", comment: "") }
        static var accountVerifiedDescription: String { NSLocalizedString("inbox_screen_inside_accountVerifiedDescription", comment: "") }
        
        static var limitedDealTitle: String { NSLocalizedString("inbox_screen_inside_limitedDealTitle", comment: "") }
        static var limitedDealSubTitle: String { NSLocalizedString("inbox_screen_inside_limitedDealSubTitle", comment: "") }
        static var limitedDealDescription: String { NSLocalizedString("inbox_screen_inside_limitedDealDescription", comment: "") }
    }
    // MARK: - Other Nested Structures
    /* Contains menu-related constants */
    struct menu {
        static var food: String { NSLocalizedString("menu_screen_food_title", comment: "") }
        static var beverages: String { NSLocalizedString("menu_screen_beverages_title", comment: "") }
        static var desserts: String { NSLocalizedString("menu_screen_desserts_title", comment: "") }
        static var items: String { NSLocalizedString("menu_screen_items", comment: "") }
        
        // Non-localized constants can stay as let
        static let separator = ", "
        static let total = "Total: $"
        static let order = "Order #"
    }
    /* Contains "More" section constants */
    struct more {
        static var paymentDetails: String { NSLocalizedString("more_screen_payment_detail_title", comment: "") }
        static var myOrder: String { NSLocalizedString("more_screen_my_order_title", comment: "") }
        static var notification: String { NSLocalizedString("more_screen_notifications_title", comment: "") }
        static var inbox: String { NSLocalizedString("more_screen_inbox_title", comment: "") }
        static var aboutUs: String { NSLocalizedString("more_screen_about_us_title", comment: "") }
        static var wishlist: String { NSLocalizedString("more_screen_wishlist_title", comment: "") }
        static var language: String { NSLocalizedString("more_screen_language_title", comment: "") }
        static var theme: String { NSLocalizedString("more_screen_theme_title", comment: "") }
    }
    /* Contains offers and ratings */
    struct offer {
        static var offerTitle1: String { NSLocalizedString("offers_screen_offers_cafe_name_1", comment: "") }
        static var offerTitle2: String { NSLocalizedString("offers_screen_offers_cafe_name_2", comment: "") }
        static var offerTitle3: String { NSLocalizedString("offers_screen_offers_cafe_name_3", comment: "") }
        static var offersCafeType: String { NSLocalizedString("offers_screen_offers_cafe_type", comment: "") }
        static var offersFoodType: String { NSLocalizedString("offers_screen_offers_food_type", comment: "") }
        static var offersLabel: String { NSLocalizedString("offers_screen_offers_label", comment: "") }
        static var checkOffersButton: String { NSLocalizedString("offers_screen_check_offers_button", comment: "") }
        
        // Non-localized constants
        static let ratings = "Ratings"
        static let starRating = "Star Ratings"
    }
    /* Data for onboarding/next pages */
    struct nextPage {
        static var nextPage1: String { NSLocalizedString("next_page_screen_title_1_text", comment: "") }
        static var nextPage1Description: String { NSLocalizedString("next_page_screen_sub_title_1_text", comment: "") }
        
        static var nextPage2: String { NSLocalizedString("next_page_screen_title_2_text", comment: "") }
        static var nextPage2Description: String { NSLocalizedString("next_page_screen_sub_title_2_text", comment: "") }
        
        static var nextPage3: String { NSLocalizedString("next_page_screen_title_3_text", comment: "") }
        static var nextPage3Description: String { NSLocalizedString("next_page_screen_sub_title_3_text", comment: "") }
    }
    /* Titles for different screens */
    struct setTitle {
        static var notificationTitle: String { NSLocalizedString("notification_screen_inside_title", comment: "") }
        static var inboxTitle: String { NSLocalizedString("inbox_screen_inside_title", comment: "") }
        static var aboutUsTitle: String { NSLocalizedString("aboutus_screen_inside_title", comment: "") }
        static var changeAddressTitle: String { NSLocalizedString("change_address_screen_title", comment: "") }
        static var cartTitle: String { NSLocalizedString("cart_screen_title", comment: "") }
        static var checkoutTitle: String { NSLocalizedString("checkout_page_screen_title", comment: "") }
        static var foodTitle: String { NSLocalizedString("menu_screen_food_title", comment: "") }
        static var beveragesTitle: String { NSLocalizedString("menu_screen_beverages_title", comment: "") }
        static var dessertsTitle: String { NSLocalizedString("menu_screen_desserts_title", comment: "") }
        static var forgotPasswordTitle: String { NSLocalizedString("forget_password_screen_title", comment: "") }
        static var menuTitle: String { NSLocalizedString("menu_screen_title", comment: "") }
        static var moreTitle: String { NSLocalizedString("more_screen_title", comment: "") }
        static var myOrderTitle: String { NSLocalizedString("my_order_screen_title", comment: "") }
        static var newPasswordTitle: String { NSLocalizedString("new_password_screen_title", comment: "") }
        static var offersTitle: String { NSLocalizedString("offers_screen_title", comment: "") }
        static var orderListTitle: String { NSLocalizedString("orderlist_screen_title", comment: "") }
        static var paymentDetailsTitle: String { NSLocalizedString("payment_details_screen_inside_title", comment: "") }
        
        // Non-localized (hardcoded for now)
        static let productDetailTitle = "Food Details"
        
        static var profileTitle: String { NSLocalizedString("edit_profile_screen_title", comment: "") }
        static var resetPasswordTitle: String { NSLocalizedString("otp_screen_title", comment: "") }
        static var signUpTitle: String { NSLocalizedString("signup_page_screen_title", comment: "") }
        static var wishlistTitle: String { NSLocalizedString("wishlist_screen_title", comment: "") }
        static var restaurantName: String { NSLocalizedString("my_order_screen_restaurant_name_label", comment: "") }
        static var popularTitle: String { NSLocalizedString("homepage_screen_popular_food_title", comment: "") }
        
        // Non-localized (hardcoded for now)
        static let searchingTitle = "Search Results"
        
        static var mostPopularTitle: String { NSLocalizedString("homepage_screen_most_popular_food_title", comment: "") }
        static var recentItemsTitle: String { NSLocalizedString("homepage_screen_recent_items_title", comment: "") }
        static var nextPageTitle: String { NSLocalizedString("next_page_screen_next_button_text", comment: "") }
        static var nextPageDoneTitle: String { NSLocalizedString("next_page_screen_done_button_text", comment: "") }
        static let homePageTitle = "Good morning, User!"
        static var profilePageTitle: String { NSLocalizedString("edit_profile_screen_hello_label", comment: "") }
    }
    /* Location and address alerts */
    struct addressAlertMessage {
        static var addressTitle: String { NSLocalizedString("change_address_screen_alert_title", comment: "") }
        static var addressMessage: String { NSLocalizedString("change_address_screen_alert_message", comment: "") }
        static var addressAction: String { NSLocalizedString("change_address_screen_alert_action", comment: "") }
        static var addressTitle2: String { NSLocalizedString("change_address_screen_alert_address_title_2", comment: "") }
        static var fullAddress: String { NSLocalizedString("change_address_screen_alert_full_address", comment: "") }
        static var identifier: String { NSLocalizedString("change_address_screen_identifier", comment: "") }
        static var addressTitle3: String { NSLocalizedString("change_address_screen_address_title_3", comment: "") }
        
        static var changeAddressTitle: String { NSLocalizedString("change_address_screen_title", comment: "") }
        static var searchAddressPlaceholder: String { NSLocalizedString("change_address_screen_search_address_textfield", comment: "") }
    }
    /* Cart alerts and formats */
    struct cartAlertMessage {
        static var cartTitle: String { NSLocalizedString("cart_screen_alert_title", comment: "") }
        static var cartMessage: String { NSLocalizedString("cart_screen_alert_message", comment: "") }
        static var cartAction: String { NSLocalizedString("cart_screen_alert_action", comment: "") }
        static var cartTitle2: String { NSLocalizedString("cart_screen_alert_title_2", comment: "") }
        static var cartMessage2: String { NSLocalizedString("cart_screen_alert_message_2", comment: "") }
        static var productAddedTitle: String { NSLocalizedString("cart_screen_alert_product_added_title", comment: "") }
        static var productAddedMessage: String { NSLocalizedString("cart_screen_alert_product_added_message", comment: "") }
        static var btnPlaceOrder: String { NSLocalizedString("cart_screen_place_order_button", comment: "") }
        
        // Constants & Formats
        static let cartFormat = "productId == %d AND user == %@ AND (status == nil OR status == 'cart')"
        static let quantityFormat = "productId == %d AND user == %@"
        static let fetchCartFormat = "user == %@ AND (status == nil OR status == 'cart')"
        static let clearCartFormat = "user == %@ AND status == 'cart'"
        static let fetchOrderFormat = "userEmail == %@"
        static let wishlistFormat = "id == %d AND user == %@"
        
        static let priceSymbol = "$"
        static let priceFormat = "%.2f"
        static let dessertPriceFormat = "%.1f"
        static let quantity = "QTY:"
    }
    /* Payment and checkout messages */
    struct checkoutAlertMessage {
        // ⚠️ Validation & Alerts
        static var cardNumberAlert: String { NSLocalizedString("checkout_screen_card_number_alert", comment: "") }
        static var expiryMonthAlert: String { NSLocalizedString("checkout_screen_expiry_month_alert", comment: "") }
        static var expiryYearAlert: String { NSLocalizedString("checkout_screen_expiry_year_alert", comment: "") }
        static var securityCodeAlert: String { NSLocalizedString("checkout_screen_security_code_alert", comment: "") }
        static var expiryMonthYearAlert: String { NSLocalizedString("checkout_screen_expiry_month_year_alert", comment: "") }
        static var cardAlertTitle: String { NSLocalizedString("checkout_screen_card_alert_title", comment: "") }
        static var firstNameAlert: String { NSLocalizedString("checkout_screen_first_name_alert", comment: "") }
        static var lastNameAlert: String { NSLocalizedString("checkout_screen_last_name_alert", comment: "") }
        static var cardAlertMessage: String { NSLocalizedString("checkout_screen_card_alert_message", comment: "") }
        static var cardSaveAction: String { NSLocalizedString("checkout_screen_card_save_action", comment: "") }
        static var cardCancelAction: String { NSLocalizedString("checkout_screen_card_cancel_action", comment: "") }
        static var cardAlertTitle2: String { NSLocalizedString("checkout_screen_card_alert_title_2", comment: "") }
        static var cardOkAction: String { NSLocalizedString("checkout_screen_card_ok_action", comment: "") }
        
        // ✅ Localized UI strings
        static var screenTitle: String { NSLocalizedString("checkout_page_screen_title", comment: "") }
        static var deliveryAddress: String { NSLocalizedString("checkout_page_screen_delivery_address_label", comment: "") }
        static var change: String { NSLocalizedString("checkout_page_screen_change_button", comment: "") }
        static var paymentMethod: String { NSLocalizedString("checkout_page_screen_payment_method_label", comment: "") }
        static var addCard: String { NSLocalizedString("checkout_page_screen_add_card_button", comment: "") }
        static var cashOnDelivery: String { NSLocalizedString("checkout_page_screen_cash_on_delivery_label", comment: "") }
        static var subTotal: String { NSLocalizedString("checkout_page_screen_sub_total_label", comment: "") }
        static var deliveryCost: String { NSLocalizedString("checkout_page_screen_delivery_cost_label", comment: "") }
        static var discount: String { NSLocalizedString("checkout_page_screen_discount_label", comment: "") }
        static var total: String { NSLocalizedString("checkout_page_screen_total_label", comment: "") }
        static var sendOrder: String { NSLocalizedString("checkout_page_screen_send_order_button", comment: "") }
        static var cardNumber: String { NSLocalizedString("checkout_page_screen_card_number_textfield", comment: "") }
        static var expiry: String { NSLocalizedString("checkout_page_screen_expiry_label", comment: "") }
        static var month: String { NSLocalizedString("checkout_page_screen_month_textfield", comment: "") }
        static var year: String { NSLocalizedString("checkout_page_screen_year_textfield", comment: "") }
        static var securityCode: String { NSLocalizedString("checkout_page_screen_security_code_textfield", comment: "") }
        static var firstName: String { NSLocalizedString("checkout_page_screen_first_name_textfield", comment: "") }
        static var lastName: String { NSLocalizedString("checkout_page_screen_last_name_textfield", comment: "") }
        static var removeCard: String { NSLocalizedString("checkout_page_screen_remove_card_label", comment: "") }
        static var addCardLabel: String { NSLocalizedString("checkout_page_screen_add_card_label", comment: "") }
        static var thankYou: String { NSLocalizedString("checkout_page_screen_thank_you_title", comment: "") }
        static var thankYouLabel: String { NSLocalizedString("checkout_page_screen_thank_you_label", comment: "") }
        static var thankYouLabel2: String { NSLocalizedString("checkout_page_screen_thank_you_label_2", comment: "") }
        static var trackOrder: String { NSLocalizedString("checkout_page_screen_track_order_button", comment: "") }
        static var backToHome: String { NSLocalizedString("checkout_page_screen_back_to_home_button", comment: "") }
    }
    /* Forget password alerts */
    struct forgetPasswordAlert {
        static var emailAlertTitle: String { NSLocalizedString("forget_password_email_alert_title", comment: "") }
        static var emailAlertMessage: String { NSLocalizedString("forget_password_email_alert_message", comment: "") }
        static var emailAlertTitle2: String { NSLocalizedString("forget_password_email_alert_title_2", comment: "") }
        static var emailAlertMessage2: String { NSLocalizedString("forget_password_email_alert_message_2", comment: "") }
        static var successAlert: String { NSLocalizedString("forget_password_success_alert", comment: "") }
        static var successMessage: String { NSLocalizedString("forget_password_success_message", comment: "") }
        static var successOkAction: String { NSLocalizedString("forget_password_success_ok_action", comment: "") }
        
        static var screenTitle: String { NSLocalizedString("forget_password_screen_title", comment: "") }
        static var screenLabel: String { NSLocalizedString("forgot_password_screen_label", comment: "") }
        static var emailTextField: String { NSLocalizedString("forgot_password_screen_email_textfield", comment: "") }
        static var sendButton: String { NSLocalizedString("forgot_password_screen_send_button", comment: "") }
    }
    /* Home screen alerts */
    struct homeAlert {
        static var homeAlertTitle: String { NSLocalizedString("homepage_screen_alert_title", comment: "") }
        static var homeAlertMessage: String { NSLocalizedString("homepage_screen_alert_message", comment: "") }
        static var homeOkAction: String { NSLocalizedString("homepage_screen_home_ok_action", comment: "") }
        static let userHomeTitle = "Good morning,"
        static var viewAllButton: String { NSLocalizedString("homepage_screen_view_all_button", comment: "") }
        static var searchPlaceholder: String { NSLocalizedString("homepage_screen_search_food_textfield", comment: "") }
    }
    /* Login screen alerts and regex */
    struct loginAlert {
        // Localized Alerts & UI Strings
        static var errorTitle: String { NSLocalizedString("login_page_screen_error_title", comment: "") }
        static var emailErrorMessage: String { NSLocalizedString("login_page_screen_email_error_message", comment: "") }
        static var passwordErrorMessage: String { NSLocalizedString("login_page_screen_password_error_message", comment: "") }
        static var validEmailAlertTitle: String { NSLocalizedString("login_page_screen_valid_email_alert_title", comment: "") }
        static var validEmailMessage: String { NSLocalizedString("login_page_screen_valid_email_message", comment: "") }
        static var validPasswordAlertTitle: String { NSLocalizedString("login_page_screen_valid_password_alert_title", comment: "") }
        static var validPasswordMessage: String { NSLocalizedString("login_page_screen_valid_password_message", comment: "") }
        static var loginErrorTitle: String { NSLocalizedString("login_page_screen_login_error_title", comment: "") }
        static var loginErrorMessage: String { NSLocalizedString("login_page_screen_login_error_message", comment: "") }
        static var loginDetailsLabel: String { NSLocalizedString("login_page_screen_login_details_label", comment: "") }
        static var emailTextField: String { NSLocalizedString("login_page_screen_email_login_textfield", comment: "") }
        static var passwordTextField: String { NSLocalizedString("login_page_screen_password_login_textfield", comment: "") }
        static var loginButton: String { NSLocalizedString("login_page_screen_login_button", comment: "") }
        static var forgotPasswordButton: String { NSLocalizedString("login_page_screen_forgot_password_button", comment: "") }
        static var orLoginLabel: String { NSLocalizedString("login_page_screen_or_login_label", comment: "") }
        static var facebookButton: String { NSLocalizedString("login_page_screen_facebook_button", comment: "") }
        static var googleButton: String { NSLocalizedString("login_page_screen_google_button", comment: "") }
        static var signupButton: String { NSLocalizedString("login_page_screen_signup_button", comment: "") }
        static var screenTitleLabel: String { NSLocalizedString("login_page_screen_title_label", comment: "") }
        
        // Non-localized constants
        static let emailPasswordFormat = "email == %@ AND password == %@"
        static let emailFormat = "email == %@"
        static let userFormat = "user == %@"
        static let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        static let testFormat = "SELF MATCHES %@"
        static let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    }
    /* Alerts for setting a new password */
    struct newPasswordAlert {
        static var newPasswordErrorMessage: String { NSLocalizedString("new_password_page_screen_new_password_error_message", comment: "") }
        static var newPasswordAlertTitle: String { NSLocalizedString("new_password_page_screen_new_password_alert_title", comment: "") }
        static var newPasswordMessage: String { NSLocalizedString("new_password_page_screen_new_password_message", comment: "") }
        static var confirmPasswordMessage: String { NSLocalizedString("new_password_page_screen_confirm_password_message", comment: "") }
        static var wrongPasswordMessage: String { NSLocalizedString("new_password_page_screen_wrong_password_message", comment: "") }
        
        static var screenTitle: String { NSLocalizedString("new_password_screen_title", comment: "") }
        static var label: String { NSLocalizedString("new_password_screen_label", comment: "") }
        static var newPasswordTextfield: String { NSLocalizedString("new_password_screen_password_textfield", comment: "") }
        static var confirmPasswordTextfield: String { NSLocalizedString("new_password_screen_confirm_password_textfield", comment: "") }
        static var nextButton: String { NSLocalizedString("new_password_screen_next_button", comment: "") }
    }
    /* Profile update alerts */
    struct profileAlert {
        // Alerts & messages
        static var invalidEmailAlertTitle: String { NSLocalizedString("profile_page_invalid_email_alert_title", comment: "") }
        static var invalidEmailAlertMessage: String { NSLocalizedString("profile_page_invalid_email_alert_message", comment: "") }
        static let newEmailFormat = "email == %@ AND self != %@"
        
        static var emailExistAlertTitle: String { NSLocalizedString("profile_page_email_exist_alert_title", comment: "") }
        static var emailExistAlertMessage: String { NSLocalizedString("profile_page_email_exist_alert_message", comment: "") }
        
        static var noFieldChangedAlert: String { NSLocalizedString("profile_page_no_field_changed_alert", comment: "") }
        static var noFieldChangedMessage: String { NSLocalizedString("profile_page_no_field_changes_message", comment: "") }
        
        static var successAlertTitle: String { NSLocalizedString("profile_page_success_alert_title", comment: "") }
        static var successAlertMessage: String { NSLocalizedString("profile_page_success_alert_message", comment: "") }
        static var otpSuccessMessage: String { NSLocalizedString("profile_page_otp_success_message", comment: "") }
        
        // UI Labels & Buttons
        static var profileLabel: String { NSLocalizedString("edit_profile_screen_profile_label", comment: "") }
        static var helloLabel: String { NSLocalizedString("edit_profile_screen_hello_label", comment: "") }
        static var signOutButton: String { NSLocalizedString("edit_profile_screen_sign_out_button", comment: "") }
        static var nameTextField: String { NSLocalizedString("edit_profile_screen_name_textfield", comment: "") }
        static var emailTextField: String { NSLocalizedString("edit_profile_screen_email_textfield", comment: "") }
        static var mobileTextField: String { NSLocalizedString("edit_profile_screen_mobile_no_textfield", comment: "") }
        static var addressTextField: String { NSLocalizedString("edit_profile_screen_address_textfield", comment: "") }
        static var saveButton: String { NSLocalizedString("edit_profile_screen_save_button", comment: "") }
        static var editProfileButton: String { NSLocalizedString("edit_profile_screen_profile_label", comment: "") }
    }
    /* Sign-up related alerts */
    struct signUpAlert {
        // Alerts & messages
        static var missingInfoAlertTitle: String { NSLocalizedString("signup_page_screen_missing_info_alert_title", comment: "") }
        static var missingInfoAlertMessage: String { NSLocalizedString("signup_page_screen_missing_info_alert_message", comment: "") }
        static var invalidConfirmPassword: String { NSLocalizedString("signup_pagesignup_page_screen_invalid_confirm_password_screen_title", comment: "") }
        static var invalidConfirmPasswordMessage: String { NSLocalizedString("signup_page_screen_invalid_confirm_password_message", comment: "") }
        static var existedEmailAlertTitle: String { NSLocalizedString("signup_page_screen_existed_email_alert_title", comment: "") }
        static var existedEmailAlertMessage: String { NSLocalizedString("signup_page_screen_existed_email_alert_message", comment: "") }
        static var passwordAlertMessage: String { NSLocalizedString("signup_page_screen_password_alert_message", comment: "") }

        // UI Labels & Buttons
        static var screenTitleLabel: String { NSLocalizedString("signup_page_screen_title", comment: "") }
        static var signUpDetailLabel: String { NSLocalizedString("signup_page_screen_signup_detail_label", comment: "") }
        static var nameTextField: String { NSLocalizedString("signup_page_screen_name_textfield", comment: "") }
        static var emailTextField: String { NSLocalizedString("signup_page_screen_email_textfield", comment: "") }
        static var mobileTextField: String { NSLocalizedString("signup_page_screen_mobile_no_textfield", comment: "") }
        static var addressTextField: String { NSLocalizedString("signup_page_screen_address_textfield", comment: "") }
        static var passwordTextField: String { NSLocalizedString("signup_page_screen_password_textfield", comment: "") }
        static var confirmPasswordTextField: String { NSLocalizedString("signup_page_screen_confirm_password_textfield", comment: "") }
        static var signUpButton: String { NSLocalizedString("signup_page_screen_signup_button", comment: "") }
        static var loginButton: String { NSLocalizedString("signup_page_screen_login_button", comment: "") }
    }
    /* Lottie animation names and messages */
    struct Animation {
        static let cartAnimationName = ("Shopping Cart (1)", "Your Cart is Empty!")
        static let dessertsAnimationName = ("No data Found", "No Data Found")
        static let menuAnimationName = ("Search", "No Data Found")
        static let orderListAnimationName = ("no result found", "You have no orders yet!")
        static let paymentAnimationName = ("Card Payment Unsuccessful", "You have added no card yet!")
        static let wishlistAnimationName = ("Wishlist empty", "Your wishlist is empty!")
    }
    /* Keys for UserDefaults or persistent storage */
    struct Key {
        static let addressKey = "currentAddress"
        static let productsLoadedKey = "ProductsLoaded"
        static let loggedInUserEmailKey = "loggedInUserEmail"
        static let isLoggedInKey = "isLoggedIn"
        static let savedCardsKey = "savedCards"
        static let productNameKey = "productName"
        static let dateKey = "date"
    }
    
    struct paymentModel {
        static var addDebitCreditCardCustomizeLabel: String { NSLocalizedString("payment_details_screen_inside_label_title", comment: "") }
        static var addNewCardButton : String { NSLocalizedString("payment_detail_screen_inside_btnAddCard", comment: "") }
        static var addCardViewLabel : String { NSLocalizedString("payment_detail_screen_inside_view_label", comment: "") }
        static var cardNumberPlaceholder : String { NSLocalizedString("payment_detail_screen_inside_view_cardnumber_textfield", comment: "") }
        static var monthPlaceholder : String { NSLocalizedString("payment_detail_screen_inside_view_month_textfield", comment: "") }
        static var yearPlaceholder : String { NSLocalizedString("payment_detail_screen_inside_view_year_textfield", comment: "") }
        static var expiryLabel : String { NSLocalizedString("payment_detail_screen_inside_view_expiry_label", comment: "") }
        static var securityCodePlaceholder : String { NSLocalizedString("payment_detail_screen_inside_view_securityCode_label", comment: "") }
        static var firstNamePlaceholder : String { NSLocalizedString("payment_detail_screen_inside_view_firstName_label", comment: "") }
    static var lastNamePlaceholder : String { NSLocalizedString("payment_detail_screen_inside_view_lastName_label", comment: "") }
    static var removeCardLabel : String { NSLocalizedString("payment_detail_screen_inside_view_removeCard_label", comment: "") }
    static var addCardButton : String { NSLocalizedString("payment_detail_screen_inside_view_btnAddCard", comment: "") }
    }
    
    struct otpModel {
        static var screenTitle: String { NSLocalizedString("otp_screen_title", comment: "") }
        static var labelTitle: String { NSLocalizedString("otp_screen_label_title", comment: "") }
        static var labelSubTitle: String { NSLocalizedString("otp_screen_label_2_title", comment: "") }
        static var nextButton: String { NSLocalizedString("otp_screen_next_button", comment: "") }
        static var clickHereButton: String { NSLocalizedString("otp_screen_click_here_button", comment: "") }
    }
    
    struct myOrderModel {
        static var screenTitle : String { NSLocalizedString("my_order_screen_title", comment: "") }
        static var restaurantName : String { NSLocalizedString("my_order_screen_restaurant_name_label", comment: "") }
        static var rating : String { NSLocalizedString("my_order_screen_rating_label", comment: "") }
        static var address : String { NSLocalizedString("my_order_screen_address_label", comment: "") }
        static var deliveryInstruction : String { NSLocalizedString("my_order_screen_delivery_instruction_label", comment: "") }
        static var subTotal : String { NSLocalizedString("my_order_screen_sub_total_label", comment: "") }
        static var deliveryCost : String { NSLocalizedString("my_order_screen_delivery_cost_label", comment: "") }
        static var total : String { NSLocalizedString("my_order_screen_total_label", comment: "") }
        static var checkout : String { NSLocalizedString("my_order_screen_checkout_button", comment: "") }
        static var addNotes : String { NSLocalizedString("my_order_screen_add_notes_button", comment: "") }
    }
}
