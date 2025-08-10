//
//  ProductDetailViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var lblLKR: UILabel!
    @IBOutlet weak var viewScroll: UIScrollView!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var stackPortion: UIStackView!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var stackIngredients: UIStackView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRatting: UILabel!
    @IBOutlet weak var productDetailView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnMinusClick(_ sender: Any) {
    }
    
    @IBAction func btnPlusClick(_ sender: Any) {
    }
    
    @IBAction func btnAddToCartClick(_ sender: Any) {
    }
}
