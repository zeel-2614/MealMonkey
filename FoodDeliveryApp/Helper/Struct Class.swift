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
        static let strText1 = "Our mission is to deliver a seamless and intuitive shopping experience that prioritizes user satisfaction. We aim to create a platform where browsing, purchasing, and managing products feels effortless, thanks to our simple user interface and reliable service."
        static let strText2 = "We are dedicated to maintaining high standards of performance, transparency, and trust. Our team continuously works to enhance app functionality, ensure data privacy, and provide responsive customer support, making your shopping journey smooth and secure."
        static let strText3 = "Your feedback matters. If you have any questions, suggestions, or encounter any issues, we’re here to help. Reach out through our support page or email us directly. Together, we strive to build a better and more inclusive experience for everyone."
        static let strText4 = "We believe that technology should serve people. That’s why we constantly refine our platform based on real user behavior and needs, aiming to make every interaction faster, simpler, and more enjoyable."
        static let strText5 = "Security is our priority. We use industry-standard protocols to safeguard your personal information and provide a safe and secure shopping environment at all times."
        static let strText6 = "We value accessibility and inclusiveness. Our platform is designed to be usable by people of all backgrounds, devices, and technical abilities, ensuring that everyone can benefit from our services."
        static let strText7 = "Sustainability matters to us. We support eco-friendly business practices and work with partners who share our values to reduce our environmental impact."
    }
    // MARK: - Notification Data Model
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
    // MARK: - Inbox Model Data
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
    // MARK: - Other Nested Structures
    /* Contains menu-related constants */
    struct menu {
        static let food = "Food"
        static let beverages = "Beverages"
        static let desserts = "Desserts"
        static let items = "Items"
        static let separator = ", "
        static let total = "Total: $"
        static let order = "Order #"
    }
    /* Contains "More" section constants */
    struct more {
        static let paymentDetails = "Payment Details"
        static let myOrder = "My Orders"
        static let notification = "Notifications"
        static let inbox = "Inbox"
        static let aboutUs = "About Us"
        static let wishlist = "Wishlist"
    }
    /* Contains offers and ratings */
    struct offer {
        static let offerTitle1 = ("Cafe de Noires", "Cafe", "Western Food")
        static let offerTitle2 = ("Isso", "Cafe", "Wester Food")
        static let offerTitle3 = ("Cafe Beans", "Cafe", "Western Food")
        static let ratings = "Ratings"
        static let starRating = "Star Ratings"
    }
    /* Data for onboarding/next pages */
    struct nextPage {
        static let nextPage1 = ("Find Food You Love", "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep")
        static let nextPage2 = ("Fast Delivery", "Fast food delivery to your home, office wherever you are")
        static let nextPage3 = ("Live Tracking", "Real time tracking of your food on the app once you placed the order")
    }
    /* Titles for different screens */
    struct setTitle {
        static let notificationTitle = "Notifications"
        static let inboxTitle = "Inbox"
        static let aboutUsTitle = "About Us"
        static let changeAddressTitle = "Change Address"
        static let cartTitle = "Cart"
        static let checkoutTitle = "Checkout"
        static let foodTitle = "Food"
        static let beveragesTitle = "Beverages"
        static let dessertsTitle = "Desserts"
        static let forgotPasswordTitle = "Forgot Password"
        static let menuTitle = "Menu"
        static let moreTitle = "More"
        static let myOrderTitle = "My Order"
        static let newPasswordTitle = "New Password"
        static let offersTitle = "Latest Offers"
        static let orderListTitle = "Order List"
        static let paymentDetailsTitle = "Payment Details"
        static let productDetailTitle = "Food Details"
        static let profileTitle = "Profile"
        static let resetPasswordTitle = "OTP"
        static let signUpTitle = "Sign Up"
        static let wishlistTitle = "Wishlist"
        static let restaurantName = "Meal Monkey"
        static let popularTitle = "Popular"
        static let searchingTitle = "Search Results"
        static let mostPopularTitle = "Most Popular"
        static let recentItemsTitle = "Recent Items"
        static let nextPageTitle = "Next"
        static let nextPageDoneTitle = "Done"
        static let homePageTitle = "Good morning, User!"
        static let profilePageTitle = "Hello there, User!"
    }
    /* Location and address alerts */
    struct addressAlertMessage {
        static let addressTitle = "Location Permission Needed"
        static let addressMessage = "Please enable location access in Settings to use this feature."
        static let addressAction = "Cancel"
        static let addressTitle2 = "Open Settings"
        static let fullAddress = "Unknown Location"
        static let identifier = "CustomPin"
        static let addressTitle3 = "Loading address..."
    }
    /* Cart alerts and formats */
    struct cartAlertMessage {
        static let cartTitle = "Order Placed"
        static let cartMessage = "Your order has been placed successfully!"
        static let cartAction = "OK"
        static let cartTitle2 = "Cart is Empty"
        static let cartMessage2 = "Please add items to your cart before placing an order."
        static let productAddedTitle = "Success"
        static let productAddedMessage = "Product added to cart successfully."
        static let cartFormat = "productId == %d AND user == %@ AND (status == nil OR status == 'cart')"
        static let quantityFormat = "productId == %d AND user == %@"
        static let fetchCartFormat = "user == %@ AND (status == nil OR status == 'cart')"
        static let clearCartFormat = "user == %@ AND status == 'cart'"
        static let fetchOrderFormat = "userEmail == %@"
        static let wishlistFormat = "id == %d AND user == %@"
        static let priceSymbol = "$"
        static let priceFormat = "%.2f"
        static let quantity = "QTY:"
        static let dessertPriceFormat = "%.1f"
    }
    /* Payment and checkout messages */
    struct checkoutAlertMessage {
        static let cardNumberAlert = "Card number must be exactly 16 digits."
        static let expiryMonthAlert = "Expiry month must be between 01 and 12."
        static let expiryYearAlert = "Expiry year must be 2 digits"
        static let securityCodeAlert = "Security code must be 3 digits."
        static let expiryMonthYearAlert = "Card expiry date cannot be in the past."
        static let cardAlertTitle = "Confirm Card Details"
        static let firstNameAlert = "Please enter your first name."
        static let lastNameAlert = "Please enter your last name."
        static let cardAlertMessage = "Do you want to save this card?"
        static let cardSaveAction = "Save"
        static let cardCancelAction = "Cancel"
        static let cardAlertTitle2 = "Invalid Input"
        static let cardOkAction = "OK"
    }
    /* Forget password alerts */
    struct forgetPasswordAlert {
        static let emailAlertTitle = "Email Missing"
        static let emailAlertMessage = "Please enter your Email."
        static let emailAlertTitle2 = "Invalid Email"
        static let emailAlertMessage2 = "Please enter a valid Email."
        static let successAlert = "Success"
        static let successMessage = "OTP Sent Successfully"
        static let successOkAction = "OK"
    }
    /* Home screen alerts */
    struct homeAlert {
        static let homeAlertTitle = "Error"
        static let homeAlertMessage = "Failed to load products. Please try again."
        static let homeOkAction = "OK"
        static let userHomeTitle = "Good morning,"
    }
    /* Login screen alerts and regex */
    struct loginAlert {
        static let errorTitle = "Error"
        static let emailErrorMessage = "Please enter your email address."
        static let passwordErrorMessage = "Please enter your password."
        static let validEmailAlertTitle = "Invalid Email"
        static let validEmailMessage = "Please enter a valid email address."
        static let validPasswordAlertTitle = "Invalid Password"
        static let validPasswordMessage = "Password must include uppercase, lowercase, number and special character."
        static let emailPasswordFormat = "email == %@ AND password == %@"
        static let emailFormat = "email == %@"
        static let loginErrorTitle = "Login Failed"
        static let loginErrorMessage = "User not registered or invalid email or password."
        static let userFormat = "user == %@"
        static let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        static let TestFormat = "SELF MATCHES %@"
        static let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
    }
    /* Alerts for setting a new password */
    struct newPasswordAlert {
        static let newPasswordErrorMessage = "Please enter your new password."
        static let newPasswordAlertTitle = "Invalid Password"
        static let newPasswordMessage = "Password must include uppercase, lowercase, number and special character."
        static let confirmPasswordMessage = "Please confirm your new password."
        static let wrongPasswordMessage = "Passwords do not match."
    }
    /* Profile update alerts */
    struct profileAlert {
        static let invalidEmailAlertTitle = "Invalid Email"
        static let invalidEmailAlertMessage = "Please enter a valid email address."
        static let newEmailFormat = "email == %@ AND self != %@"
        static let emailExistAlertTitle = "Email Exists"
        static let emailExistAlertMessage = "This email address is already registered with another account"
        static let noFieldChangedAlert = "Info"
        static let noFieldChangedMessage = "No changes detected."
        static let successAlertTitle = "Success"
        static let successAlertMessage = "Profile updated successfully."
        static let otpSuccessMessage = "OTP sent successfully."
    }
    /* Sign-up related alerts */
    struct signUpAlert {
        static let missingInfoAlertTitle = "Missing Info"
        static let missingInfoAlertMessage = "Please enter all fields"
        static let invalidConfirmPassword = "Passwords do not match."
        static let invalidConfirmPasswordMessage = "The password and confirm password must be the same."
        static let existedEmailALertTitle = "Error"
        static let existedEmailALertMessage = "Email already registered. Please login."
        static let passwordAlertMessage = "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character."
    }
    /* Lottie animation names and messages */
    struct Animation {
        static let cartAnimationName = ("Shopping Cart", "Your Cart is Empty!")
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
}
