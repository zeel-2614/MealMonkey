//
//  ProductDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Properties
    var selectedProduct: ProductModel?
    var currentQuantity: Int = 1
    var isHeartFilled = false
    
    // MARK: - IBOutlets
    @IBOutlet weak var productDetailActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var btnCart: UIButton!
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
        setLeftAlignedTitleWithBack("Food Detail", target: self, action: #selector(detailBackBtnTapped))
        setCartButtonWithBadge(target: self, action: #selector(cartBtnTapped))
        // ✅ Set navigation bar title and icon color to white
        currentQuantity = 1
        showLoadingState()
        
        if let product = selectedProduct {
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "$\(product.doubleProductPrice)"
            lblRattings.text = "\(product.floatProductRating) Star Ratings"
            imgProduct.image = UIImage(named: product.strProductImage)
        }
        // Do any additional setup after loading the view.
        
        if let product = selectedProduct,
           let user = CoreDataManager.shared.getOrCreateCurrentUser(),
           CoreDataManager.shared.isInWishlist(productId: product.intId, for: user) {
            btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
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

            // ✅ Force layout update
            navBar?.layoutIfNeeded()
    }
    // MARK: - Navigation Button Actions
    @objc func detailBackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cartBtnTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    // MARK: - UI Setup
    func configureUI() {
        guard let product = selectedProduct else { return }
        lblTitle.text = product.strProductName
        lblDescription.text = product.strProductDescription
        imgProduct.image = UIImage(named: product.strProductImage)
        lblRattings.text = "\(product.floatProductRating) (\(product.intTotalNumberOfRatings) ratings)"
        updatePriceAndQuantityUI()
    }
    
    func updatePriceAndQuantityUI() {
        guard let product = selectedProduct else { return }
        let total = product.doubleProductPrice * Double(currentQuantity)
        lblPrice.text = "$\(String(format: "%.2f", product.doubleProductPrice))"
        lblLKR.text = "$\(String(format: "%.2f", total))"
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
        
        // ✅ Use fetchCartItems instead of getCartItems
        let cartCount = CoreDataManager.shared.fetchCartItems(for: user).count
        CartBadgeManager.shared.updateCartCount(to: cartCount)
        
        let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    // MARK: - Cart Button
    @IBAction func btnCartClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }
    
    @IBAction func btnHeartClick(_ sender: UIButton) {
        guard let product  = selectedProduct,
              let user = CoreDataManager.shared.getOrCreateCurrentUser() else { return }
        
        if CoreDataManager.shared.isInWishlist(productId: product.intId, for: user) {
            CoreDataManager.shared.removeFromWishlist(productId: product.intId, for: user)
            btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            CoreDataManager.shared.addToWishlist(product: product, for: user)
            btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
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
        // Initially hide content and show loader
        productDetailView.isHidden = true
        imgProduct.isHidden = true
        btnHeart.isHidden = true
        productDetailActivityIndicator.startAnimating()
        
        // Simulate a loading delay of 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self = self else { return }
            
            self.productDetailActivityIndicator.stopAnimating()
            self.productDetailView.isHidden = false
            self.imgProduct.isHidden = false
            self.btnHeart.isHidden = false
            
            // Set up the UI after "loading"
            self.setupUI()
            self.configureUI()
        }
    }
}
