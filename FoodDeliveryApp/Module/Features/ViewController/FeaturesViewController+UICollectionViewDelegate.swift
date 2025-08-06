//
//  FeaturesViewController+UICollectionViewDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import Foundation
import UIKit

extension FeaturesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FeaturesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCollectionViewCell", for: indexPath) as! FeaturesCollectionViewCell

        cell.imgView.image = UIImage(named: arrService[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrService.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, 300)
    }
}
