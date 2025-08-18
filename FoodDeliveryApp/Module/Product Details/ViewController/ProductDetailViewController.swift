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
        setupUI()
        
        setLeftAlignedTitleWithBack("Food Detail", target: self, action: #selector(detailBackBtnTapped))
        setCartButton(target: self, action: #selector(cartBtnTapped))
        
        configureUI()
        currentQuantity = 1
        
        if let product = selectedProduct {
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "$\(product.doubleProductPrice)"
            lblRattings.text = "\(product.floatProductRating) Star Ratings"
            imgProduct.image = UIImage(named: product.strProductImage)
        }
        // Do any additional setup after loading the view.
        
        if let appDelegate = appDelegate,
           appDelegate.arrWishlist.contains(where: { $0.intId == selectedProduct?.intId }) {
            btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
        }
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
        self.title = product.strProductName
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
        print("add too cart from detail Page")
        guard let product = selectedProduct else {
            print("Error: No product selected to add to cart.")
            return
        }
        checkProduct(productToAdd: product)
        let alert = UIAlertController(title: "Success", message: "Added to cart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func checkProduct(productToAdd: ProductModel) {
        guard let appDelegate = appDelegate else { return }
        if let existingIndex = appDelegate.arrCart.firstIndex(where: { $0.intId == productToAdd.intId }) {
            appDelegate.arrCart[existingIndex].intProductQty = currentQuantity
            print("Updated \(productToAdd.strProductName) quantity to \(currentQuantity).")
        } else {
            let newProduct = productToAdd
            newProduct.intProductQty = currentQuantity
            appDelegate.arrCart.append(newProduct)
            print("Added \(productToAdd.strProductName) with quantity \(currentQuantity).")
        }
        
        let cartDictArray = appDelegate.arrCart.map { productToDict($0) }
        saveCartToUserDefaults(cartArray: cartDictArray)
    }
    
    // MARK: - Cart Button
    @IBAction func btnCartClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let cartVc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(cartVc, animated: true)
        }
    }
    @IBAction func btnHeartClick(_ sender: UIButton) {
        guard let product  = selectedProduct else {return}
        guard let appDelegate = appDelegate else {return}
        
        if let existingIndex = appDelegate.arrWishlist.firstIndex(where: {$0 .intId == product.intId}) {
            appDelegate.arrWishlist.remove(at: existingIndex)
            btnHeart.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else {
            appDelegate.arrWishlist.append(product)
            btnHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        saveWishlist(appDelegate.arrWishlist)
    }
    
    // MARK: - Styling
    private func setupUI() {
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
}
