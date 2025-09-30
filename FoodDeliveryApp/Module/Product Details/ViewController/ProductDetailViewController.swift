//
//  ProductDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import UIKit
import NVActivityIndicatorView

class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    var selectedProduct: ProductModel?
    var currentQuantity: Int = 1
    var isHeartFilled = false
    var activityLoader: NVActivityIndicatorView?
    // MARK: - IBOutlets
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var lblLKR: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var stackIngredients: UIStackView!
    @IBOutlet weak var stackPortion: UIStackView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRattings: UILabel!
    @IBOutlet weak var productDetailView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewScroll: UIScrollView!
    
    // Reference to AppDelegate for accessing shared cart array
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewScroll.showsVerticalScrollIndicator = false
        setLeftAlignedTitleWithBack(Main.setTitle.productDetailTitle, target: self, action: #selector(detailBackBtnTapped))
        setCartButtonWithBadge(target: self, action: #selector(cartBtnTapped))
        // Set navigation bar title and icon color to white
        currentQuantity = 1
        showLoadingState()
        applyTheme()
        
        if let product = selectedProduct {
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "\(Main.cartAlertMessage.priceSymbol)\(product.doubleProductPrice)"
            lblRattings.text = "\(product.floatProductRating) \(Main.offer.starRating)"
            imgProduct.image = UIImage(named: product.strProductImage)
        }
        // Do any additional setup after loading the view.
        
        if let product = selectedProduct,
           let user = CoreDataManager.shared.getOrCreateCurrentUser(),
           CoreDataManager.shared.isInWishlist(productId: product.intId, for: user) {
            btnHeart.setImage(UIImage(systemName: Main.Images.btnWishlist), for: .normal)
        } else {
            btnHeart.setImage(UIImage(systemName: Main.Images.btnWishlistState), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)   // <-- This was missing
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        // Apply navigation bar styling after adding buttons
        if let user = CoreDataManager.shared.getOrCreateCurrentUser() {
            CartBadgeManager.shared.syncCartCount(for: user)
        }
        applyTheme()
        
        let navBar = navigationController?.navigationBar
            navigationController?.setNavigationBarHidden(false, animated: animated)
            
            // Force white tint and text
            navBar?.tintColor = .white
            navBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            // Clear background
            navBar?.setBackgroundImage(UIImage(), for: .default)
            navBar?.shadowImage = UIImage()
            navBar?.isTranslucent = true
            navBar?.backgroundColor = .clear

            // Force layout update
            navBar?.layoutIfNeeded()
    }
    // MARK: - Navigation Button Actions
    @objc func detailBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    // MARK: - UI Setup
    func configureUI() {
        guard let product = selectedProduct else { return }
        lblTitle.text = product.strProductName
        lblDescription.text = product.strProductDescription
        imgProduct.image = UIImage(named: product.strProductImage)
        lblRattings.text = "\(product.floatProductRating) (\(product.intTotalNumberOfRatings) \(Main.offer.ratings))"
        updatePriceAndQuantityUI()
    }
    
    func updatePriceAndQuantityUI() {
        guard let product = selectedProduct else { return }
        let total = product.doubleProductPrice * Double(currentQuantity)
        lblPrice.text = "\(Main.cartAlertMessage.priceSymbol)\(String(format: Main.cartAlertMessage.priceFormat, product.doubleProductPrice))"
        lblLKR.text = "\(Main.cartAlertMessage.priceSymbol)\(String(format: Main.cartAlertMessage.priceFormat, total))"
        lblCount.text = "\(currentQuantity)"
    }
    
    // MARK: - Quantity Buttons
    @IBAction func btnMinusClick(_ sender: Any) {
        if currentQuantity > 1 {
            currentQuantity -= 1
            updatePriceAndQuantityUI()
        }
    }
    
    @IBAction func btnPlusClick(_ sender: Any) {
        currentQuantity += 1
        updatePriceAndQuantityUI()
    }
    // MARK: - Add to Cart
    @IBAction func btnAddToCartClick(_ sender: Any) {
        guard let product = selectedProduct,
              let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        
        CoreDataManager.shared.addOrUpdateCartItem(product: product, quantity: Int16(currentQuantity), for: user)
        
        // Use fetchCartItems instead of getCartItems
        let cartCount = CoreDataManager.shared.fetchCartItems(for: user).count
        CartBadgeManager.shared.updateCartCount(to: cartCount)
        
        let alert = UIAlertController(title: Main.cartAlertMessage.productAddedTitle, message: Main.cartAlertMessage.productAddedMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Main.cartAlertMessage.cartAction, style: .default))
        present(alert, animated: true)
    }
    // MARK: - Cart Button
    @IBAction func btnCartClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Main.Storyboards.productStoryBoard, bundle: nil)
        if let cartVc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.cartViewController) as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }
    
    @IBAction func btnHeartClick(_ sender: UIButton) {
        guard let product  = selectedProduct,
              let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        
        if CoreDataManager.shared.isInWishlist(productId: product.intId, for: user) {
            CoreDataManager.shared.removeFromWishlist(productId: product.intId, for: user)
            btnHeart.setImage(UIImage(systemName: Main.Images.btnWishlistState), for: .normal)
        } else {
            CoreDataManager.shared.addToWishlist(product: product, for: user)
            btnHeart.setImage(UIImage(systemName: Main.Images.btnWishlist), for: .normal)
        }
    }
    
    // MARK: - Styling
    func setupUI() {
        // Style stacks
        viewStyle(cornerRadius: 4, borderWidth: 0, borderColor: .gray, textField: [stackPortion, stackIngredients])
        viewStyle(cornerRadius: 15, borderWidth: 0, borderColor: .gray, textField: [btnPlus, btnMinus])
        viewStyle(cornerRadius: 7.42, borderWidth: 0, borderColor: .gray, textField: [btnAddToCart])
        viewStyle(cornerRadius: 15, borderWidth: 1, borderColor: .buttonBackground, textField: [countView])
        
        // Style scroll view
        viewScroll.layer.cornerRadius = 42
        viewScroll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewScroll.clipsToBounds = true
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.3
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
        // Style product detail view
        productDetailView.layer.cornerRadius = 42
        productDetailView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        productDetailView.layer.shadowColor = UIColor.black.cgColor
        productDetailView.layer.shadowOpacity = 0.3
        productDetailView.layer.shadowOffset = CGSize(width: 0, height: -2)
        productDetailView.layer.shadowRadius = 10
    }
    
    func showLoadingState() {
        // Hide content first
        productDetailView.isHidden = true
        imgProduct.isHidden = true
        btnHeart.isHidden = true

        // Create loader frame (centered in the screen)
        let loaderFrame = CGRect(
            x: (view.frame.width - 50) / 2,
            y: (view.frame.height - 50) / 2,
            width: 50,
            height: 50
        )

        // Initialize loader only once
        if activityLoader == nil {
            activityLoader = NVActivityIndicatorView(
                frame: loaderFrame,
                type: .ballScaleRippleMultiple,
                color: .buttonBackground,
                padding: 0
            )
            if let loader = activityLoader {
                view.addSubview(loader)
            }
        }

        // Start loader animation
        activityLoader?.startAnimating()

        // Simulate loading delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self = self else { return }

            // Stop loader and hide it
            self.activityLoader?.stopAnimating()
            self.activityLoader?.removeFromSuperview()
            self.activityLoader = nil

            // Show product details after loading
            self.productDetailView.isHidden = false
            self.imgProduct.isHidden = false
            self.btnHeart.isHidden = false

            // Update UI with data
            self.setupUI()
            self.configureUI()
        }
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        view.backgroundColor = theme.backgroundColor
        detailView.backgroundColor = theme.backgroundColor
        productDetailView.backgroundColor = theme.cardCellBackgroundColor  // mapped from cardCellBackgroundColor
        lblTitle.textColor = theme.labelTextColor                          // mapped from labelTextColor
        lblDescription.textColor = theme.labelTextColor                    // mapped from labelTextColor
        lblPrice.textColor = theme.buttonColor                              // mapped from buttonColor
        lblLKR.textColor = theme.buttonColor                                // mapped from buttonColor
        lblRattings.textColor = theme.labelTextColor                        // mapped from labelTextColor
        btnAddToCart.backgroundColor = theme.buttonColor                    // mapped from buttonColor
        btnHeart.tintColor = theme.buttonColor                               // mapped from buttonColor
    }
}
