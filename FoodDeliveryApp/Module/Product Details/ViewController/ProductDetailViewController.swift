//
//  ProductDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var selectedProduct: ProductModel?
    var currentQuantity: Int = 1
    
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
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewScroll.showsVerticalScrollIndicator = false
        
        viewStyle(cornerRadius: 4, borderWidth: 0, borderColor: .gray, textField: [stackPortion, stackIngredients])
        viewStyle(cornerRadius: 15, borderWidth: 0, borderColor: .gray, textField: [btnPlus, btnMinus])
        viewStyle(cornerRadius: 7.42, borderWidth: 0, borderColor: .gray, textField: [btnAddToCart])
        
        viewScroll.layer.cornerRadius = 20
        viewScroll.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]
        
        viewScroll.layer.shadowColor = UIColor.black.cgColor
        viewScroll.layer.shadowOpacity = 0.3
        viewScroll.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewScroll.layer.shadowRadius = 10
        
        productDetailView.layer.cornerRadius = 20
        productDetailView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner,
        ]
        
        productDetailView.layer.shadowColor = UIColor.black.cgColor
        productDetailView.layer.shadowOpacity = 0.3
        productDetailView.layer.shadowOffset = CGSize(width: 0, height: -2)
        productDetailView.layer.shadowRadius = 10
        
        configureUI()
        currentQuantity = 1
        
        if let product = selectedProduct {
            lblTitle.text = product.strProductName
            lblDescription.text = product.strProductDescription
            lblPrice.text = "\(product.doubleProductPrice)"
            lblRattings.text = "\(product.floatProductRating) ★"
            imgProduct.image = UIImage(named: product.strProductImage)
        }
        // Do any additional setup after loading the view.
    }
    
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
        lblPrice.text = "$\(String(format: "%.2f", total))"
        lblCount.text = "\(currentQuantity)"
    }
    
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
    }
    
    @IBAction func btnCartClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let carVc = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                carVc,
                animated: true
            )
        }
    }
}
