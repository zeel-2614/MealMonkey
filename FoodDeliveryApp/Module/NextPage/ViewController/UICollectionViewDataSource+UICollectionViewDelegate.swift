import Foundation
import UIKit

/// Extension to handle collection view data source, delegate, and layout for the onboarding pages.
extension NextPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Returns the number of onboarding items.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    /// Configures and returns a cell for the given index path.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue the reusable onboarding cell
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Main.CellIdentifiers.nextPageCollectionViewCell,
            for: indexPath
        ) as! CollectionViewCellNextPageCollectionViewCell
        
        // Get the feature model for this index
        let model = features[indexPath.item]
        
        // Configure the cell with the feature data
        cell.configure(with: model)
        
        return cell
    }
    
    /// Returns the size for each onboarding cell (full width, fixed height).
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 313.26)
    }
}

/// Extension to handle scroll view events for updating the onboarding UI when scrolling.
extension NextPageViewController: UIScrollViewDelegate {
    
    /// Called when the user finishes swiping between pages.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        updateLabels(for: pageNumber)
    }
    
    /// Called when scrolling animation (e.g., programmatic scroll) finishes.
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        updateLabels(for: index)
    }
}
