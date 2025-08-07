//
//  OffersViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 07/08/25.
//

import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var btnCheckOffers: UIButton!
    @IBOutlet weak var tblOffers: UITableView!
    
    var arrOffer : [offer] = offer.getAllOffers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitle("Latest Offers") // optional, only if this is implemented correctly
        setCartButton(target: self, action: #selector(cartTapped))
            
        tblOffers.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
            
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false

        // Do any additional setup after loading the view.
    }
    
    @objc func cartTapped() {
        print("Cart tapped")
    }
    
    @IBAction func btnCheckOffersClick(_ sender: Any) {
    }
}
