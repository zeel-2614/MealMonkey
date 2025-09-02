//
//  Struct Class.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 29/08/25.
//

import Foundation

struct Main {
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
    
    struct Images {
        static let dessertsBackShade = "ic_desserts_back_shade"
        static let all = "ic_all"
        static let paneertikka = "ic_paneertikka"
        static let hakkanoodles = "ic_hakkanoodles"
        static let khamanDhokla = "Ic_Khaman_Dhokla"
        static let masalaDosa = "ic_masaladosa"
        static let margheritaPizza = "ic_margherita_pizza"
        static let food = "ic_Food"
        static let beverages = "ic_Beverages"
        static let desserts = "ic_Desserts"
        static let paymentDetails = "ic_payment_details"
        static let myOrders = "ic_my_order"
        static let notification = "ic_notification"
        static let inbox = "ic_inbox"
        static let aboutUs = "ic_aboutus"
        static let wishlist = "ic_wishlist"
        static let image1 = "ic_image1"
        static let image2 = "ic_image2"
        static let image3 = "ic_image3"
        static let offer1 = "ic_offer1"
        static let offer2 = "ic_offer2"
        static let offer3 = "ic_offer3"
        static let addressCustomPin = "ic_current_position"
    }
    
    struct Storyboards {
        static let productStoryBoard = "ProductStoryboard"
        static let homeStoryBoard = "HomeStoryboard"
        static let menuStoryBoard = "MenuStoryboard"
        static let moreStoryBoard = "MoreStoryboard"
        static let userStoryBoard = "UserStoryboard"
        static let mainStoryBoard = "Main"
    }
    
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
    
    struct aboutUsModel {
        static let strText1 = "Our mission is to deliver a seamless and intuitive shopping experience that prioritizes user satisfaction. We aim to create a platform where browsing, purchasing, and managing products feels effortless, thanks to our simple user interface and reliable service."
        static let strText2 = "We are dedicated to maintaining high standards of performance, transparency, and trust. Our team continuously works to enhance app functionality, ensure data privacy, and provide responsive customer support, making your shopping journey smooth and secure."
        static let strText3 = "Your feedback matters. If you have any questions, suggestions, or encounter any issues, we’re here to help. Reach out through our support page or email us directly. Together, we strive to build a better and more inclusive experience for everyone."
        static let strText4 = "We believe that technology should serve people. That’s why we constantly refine our platform based on real user behavior and needs, aiming to make every interaction faster, simpler, and more enjoyable."
        static let strText5 = "Security is our priority. We use industry-standard protocols to safeguard your personal information and provide a safe and secure shopping environment at all times."
        static let strText6 = "We value accessibility and inclusiveness. Our platform is designed to be usable by people of all backgrounds, devices, and technical abilities, ensuring that everyone can benefit from our services."
        static let strText7 = "Sustainability matters to us. We support eco-friendly business practices and work with partners who share our values to reduce our environmental impact."
    }
    
    struct notificationModel {
        static let orderPlaced = ("Order placed successfully", "Just now")
        static let paymentConfirmed = ("Your payment has been confirmed", "5m ago")
        static let foodPrepared = ("Your food is being prepared", "10m ago")
        static let agentAssigned = ("Delivery agent assigned", "30m ago")
        static let orderOnWay = ("Your order is on the way", "1h ago")
        static let discount = ("Special discount available!", "2h ago")
        static let appUpdate = ("Download our new app update", "3h ago")
        static let referFriend = ("Refer a friend and earn", "5h ago")
        static let limitedDeal = ("Limited-time deal ending soon", "12h ago")
        static let deliveryDone = ("Delivery completed", "1d ago")
        static let rateMeal = ("Rate your last meal", "2d ago")
        static let weekendOffer = ("Weekend offer just for you", "3d ago")
        static let freeDelivery = ("Free delivery on orders above ₹299", "5d ago")
        static let thanks = ("Thanks for being with us!", "6d ago")
        static let newRestaurants = ("New restaurants added near you", "1w ago")
    }
    
    struct inboxModel {
        static let promotions = ("MealMonkey Promotions", "6th July", "Get 20% off on your next meal!")
        static let orderUpdate = ("Order Update", "6th July", "Your order is being prepared by the restaurant.")
        static let deliveryReminders = ("Delivery Reminder", "6th July", "Your delivery agent is on the way.")
        static let welcome = ("Welcome to MealMonkey", "6th July", "Thanks for joining us! Start exploring meals.")
        static let experience = ("Rate Your Experience", "6th July", "How was your recent meal order?")
        static let flashSale = ("Flash Sale", "6th July", "Enjoy 30% off on all pasta orders today only.")
        static let newRestaurants = ("New Restaurants", "6th July", "Discover trending restaurants in your area.")
        static let referEarn = ("Refer & Earn", "6th July", "Invite friends and earn ₹100 credits!")
        static let weekendSpecial = ("Weekend Special", "6th July", "Free dessert on orders above ₹499.")
        static let tips = ("MonkeyMeal Tips", "6th July", "Customize your orders with special instructions.")
        static let orderCancel = ("Order Cancelled", "6th July", "Your order has been cancelled as requested.")
        static let loyaltyProgram = ("Loyalty Program", "6th July", "Collect Monkey Points with every purchase.")
        static let securityUpdate = ("Security Update", "6th July", "Your password was recently changed.")
        static let accountVerified = ("Account Verified", "6th July", "Your account has been successfully verified.")
        static let limitedDeal = ("Limited Time Deal", "6th July", "Flat ₹50 off on biryani orders today.")
    }
    
    struct menu {
        static let food = "Food"
        static let beverages = "Beverages"
        static let desserts = "Desserts"
    }
    
    struct more {
        static let paymentDetails = "Payment Details"
        static let myOrder = "My Orders"
        static let notification = "Notifications"
        static let inbox = "Inbox"
        static let aboutUs = "About Us"
        static let wishlist = "Wishlist"
    }
}
