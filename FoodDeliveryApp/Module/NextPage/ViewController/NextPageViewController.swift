import UIKit

/// A view controller that displays a multi-page onboarding flow using a collection view and page control.
class NextPageViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionViewNextPage: UICollectionView!
    @IBOutlet weak var nextPageView: UIView!
    @IBOutlet weak var nextPageView2: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    /// All available features for the onboarding flow.
    var features: [Feature] = Feature.features
    
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
        applyTheme()
        
        // Register the custom collection view cell
        collectionViewNextPage.register(UINib(nibName: Main.CellIdentifiers.nextPageCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Main.CellIdentifiers.nextPageCollectionViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLocalizedData()
        applyTheme()
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
            let storyboard = UIStoryboard(name: Main.Storyboards.userStoryBoard, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: Main.ViewControllers.loginViewController) as? LoginViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
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
    
    func reloadLocalizedData() {
        // Rebuild features array
        let updatedFeatures: [Feature] = [
            Feature(imageName: Main.Images.image1,
                    title: Main.nextPage.nextPage1,
                    subTitle: Main.nextPage.nextPage1Description),
            Feature(imageName: Main.Images.image2,
                    title: Main.nextPage.nextPage2,
                    subTitle: Main.nextPage.nextPage2Description),
            Feature(imageName: Main.Images.image3,
                    title: Main.nextPage.nextPage3,
                    subTitle: Main.nextPage.nextPage3Description)
        ]
        
        // Update your features
        self.features = updatedFeatures
        
        // Reload UI elements
        collectionViewNextPage.reloadData()
        updateLabels(for: currentIndex)
        btnDone.setTitle(currentIndex == features.count - 1 ? Main.setTitle.nextPageDoneTitle : Main.setTitle.nextPageTitle, for: .normal)
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Background
        view.backgroundColor = theme.backgroundColor
        nextPageView.backgroundColor = theme.backgroundColor
        nextPageView2.backgroundColor = theme.backgroundColor
        
        // Labels
        lblTitle.textColor = theme.labelTextColor
        lblDescription.textColor = theme.labelTextColor
        
        // Button
        btnDone.backgroundColor = theme.buttonColor
        btnDone.setTitleColor(theme.buttonTextColor, for: .normal)
        
        // PageControl (optional styling)
        pageControl.currentPageIndicatorTintColor = theme.buttonColor
        pageControl.pageIndicatorTintColor = theme.cardCellBorderColor
    }
}
