//
//  HomeViewController+Delegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 10/08/25.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate & UITableViewDataSource implementation for HomeViewController
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows in the Home screen's table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // 1: Categories, 2: Popular, 3: Most Popular, 4: Recent Items
    }
    
    // Configure and return the cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Main.CellIdentifiers.homeTableViewCell, for: indexPath) as! HomeTableViewCell
        
        // Adjust scroll direction of the collection view inside each table view cell
        if let layout = cell.collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout {
            if indexPath.row == 0 || indexPath.row == 2 {
                layout.scrollDirection = .horizontal // Categories & Most Popular scroll horizontally
            } else {
                layout.scrollDirection = .vertical // Popular & Recent Items scroll vertically
            }
            cell.collectionViewHome.collectionViewLayout.invalidateLayout()
        }
        
        // Detect if the user is searching
        let isSearching = !(txtSearch.text ?? "").isEmpty
        
        // Configure cell based on its section
        switch indexPath.row {
        case 0:
            // Category section
            cell.collectionType = .category
            cell.selectedCategory = selectedCategory
            cell.categories = ProductCategory.allCases
            cell.lblCollectionViewTitle.isHidden = true
            cell.btnViewAll.isHidden = true
            cell.delegate = self
            cell.collectionViewHomeHeight.constant = 113 // Fixed height for horizontal category list
        case 1:
            // Popular section
            cell.collectionType = .popular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Popular"
            cell.lblCollectionViewTitle.text = isSearching ? "Search Results" : "Popular"
            cell.delegate = self
            
            // Show products based on search or category selection
            if isSearching {
                cell.products = filteredProductData.filter { $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5 }
            } else if selectedCategory == .All {
                cell.products = HomeViewController.arrProductData.filter { $0.floatProductRating >= 4.0 && $0.floatProductRating < 4.5 }
            } else {
                cell.products = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4.0 &&
                    $0.floatProductRating < 4.5 &&
                    $0.objProductCategory == selectedCategory
                }
            }
            
            // Adjust height dynamically
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
        case 2:
            // Most Popular section
            cell.collectionType = .mostPopular
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = isSearching ? "Search Results" : "Most Popular"
            cell.lblCollectionViewTitle.text = "Most Popular" // Ensures fixed title
            cell.collectionViewHomeHeight.constant = 185
            cell.delegate = self
            
            // Show products based on search or category selection
            if isSearching {
                cell.products = filteredProductData.filter { $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0 }
            } else if selectedCategory == .All {
                cell.products = HomeViewController.arrProductData.filter { $0.floatProductRating >= 4.5 && $0.floatProductRating <= 5.0 }
            } else {
                cell.products = HomeViewController.arrProductData.filter {
                    $0.floatProductRating >= 4.5 &&
                    $0.floatProductRating <= 5.0 &&
                    $0.objProductCategory == selectedCategory
                }
            }
        case 3:
            // Recent Items section
            cell.collectionType = .RecentItems
            cell.lblCollectionViewTitle.isHidden = false
            cell.btnViewAll.isHidden = false
            cell.lblCollectionViewTitle.text = "Recent Items"
            cell.products = recentItems
            cell.delegate = self
            
            // Adjust height dynamically
            cell.collectionViewHomeHeight.constant = cell.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
            
        default:
            break
        }
        // Reload the collection view inside the cell
        cell.collectionViewHome.reloadData()
        
        // Update collection height after layout
        DispatchQueue.main.async {
            cell.collectionViewHome.layoutIfNeeded()
            cell.updateCollectionHeight()
        }
        return cell
    }
}
