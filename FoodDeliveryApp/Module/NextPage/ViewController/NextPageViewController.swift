import UIKit

/// A view controller that displays a multi-page onboarding flow using a collection view and page control.
class NextPageViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionViewNextPage: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    /// All available features for the onboarding flow.
    let features: [Feature] = Feature.features
    
    /// The index of the currently displayed feature.
    var currentIndex: Int = 0
    
    /// Called after the controller's view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnDone])
        pageControl.numberOfPages = features.count
        updateLabels(for: 0)
        btnDone.setTitle(Main.setTitle.nextPageTitle, for: .normal)
        
        // Register the custom collection view cell
        collectionViewNextPage.register(UINib(nibName: Main.CellIdentifiers.nextPageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Main.CellIdentifiers.nextPageCollectionViewCell)
    }
    
    /// Shows the main tab bar as the root view controller.
    private func showMainTabBar() {
        let storyboard = UIStoryboard(name: Main.Storyboards.homeStoryBoard, bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.mainTabBarViewController) as? UITabBarController {
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
                tabBarController.selectedIndex = 2
            }
        }
    }
    
    /// Handles tap on the "Next"/"Done" button.
    @IBAction func btnDoneClick(_ sender: Any) {
        let currentPage = pageControl.currentPage
        if currentPage < features.count - 1 {
            // Scroll to next page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * collectionViewNextPage.frame.width
            collectionViewNextPage.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            pageControl.currentPage = nextPage
            updateLabels(for: nextPage)
        }
        
        else {
            showMainTabBar()
        }
    }
    
    /// Updates the title, description, page control, and button text for a given feature index.
    /// - Parameter index: The index of the feature to display.
    func updateLabels(for index: Int) {
        let model = features[index]
        lblTitle.text = model.title
        lblDescription.text = model.subTitle
        pageControl.currentPage = index
        currentIndex = index
        btnDone.setTitle(index == features.count - 1 ? Main.setTitle.nextPageDoneTitle : Main.setTitle.nextPageTitle, for: .normal)
    }
}
