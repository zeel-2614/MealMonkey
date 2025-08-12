//
//  AddressViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import UIKit
import MapKit
import CoreLocation

class AddressViewController: UIViewController {
    
    @IBOutlet weak var btnRedirectCurrentAddress: UIButton!
    @IBOutlet weak var btnSavedAddress: UIButton!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let LocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Change Address",
                                    target: self,
                                    action: #selector(btnBackTapped)
        )
        
        LocationManager.delegate = self
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        viewStyle(cornerRadius: txtSearchAddress.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchAddress])
        
        viewStyle(cornerRadius: imgStar.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [imgStar])
        
        setPadding(textfield: [txtSearchAddress])
        
        // Do any additional setup after loading the view.
    }
    
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSavedAddressClick(_ sender: Any) {
        LocationManager.requestLocation()
    }
    
    @IBAction func btnRedirectCurrentAddressClick(_ sender: Any) {
    }
}
