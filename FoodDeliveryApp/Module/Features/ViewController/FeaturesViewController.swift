//
//  FeaturesViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import UIKit

class FeaturesViewController: UIViewController {
    
    var arrService:[String] = ["ic_FeatureImage1","ic_FeatureImage2","ic_FeatureImage3"]
    
    @IBOutlet weak var lblFeatureTitle: UILabel!
    @IBOutlet weak var lblFeatureTitl2: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var featuresPageControl: UIPageControl!
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFeatureTitle.text = "Find Food You Love"
        lblFeatureTitl2.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
        
        EditStyle.setborder(textfields: [btnNext])
        
        featuresCollectionView.register(UINib(nibName: "FeaturesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturesCollectionViewCell")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        let currentPage = featuresPageControl.currentPage
        if currentPage < arrService.count - 1 {
            // Scroll to next page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * featuresCollectionView.frame.width
            featuresCollectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            featuresPageControl.currentPage = nextPage
            updateLabels(for: nextPage)
        } else {
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
        }
    }
    
    func updateLabels(for page: Int) {
        switch page {
        case 0:
            lblFeatureTitle.text = "Find Food You Love"
            lblFeatureTitl2.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
            btnNext.setTitle("Next", for: .normal)
        case 1:
            lblFeatureTitle.text = "Fast Delivery"
            lblFeatureTitl2.text = "Fast food delivery to your home, office wherever you are"
            btnNext.setTitle("Next", for: .normal)
        case 2:
            lblFeatureTitle.text = "Live Tracking"
            lblFeatureTitl2.text = "Real time tracking of your food on the app once you placed the order"
            btnNext.setTitle("Done", for: .normal)
        default:
            break
        }
    }
}
