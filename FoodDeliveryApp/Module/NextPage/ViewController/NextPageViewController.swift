import UIKit

class NextPageViewController: UIViewController {
    
    @IBOutlet weak var collectionViewNextPage: UICollectionView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    let features: [Feature] = Feature.features
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [btnDone])
        pageControl.numberOfPages = features.count
        updateLabels(for: 0)
        btnDone.setTitle("Next", for: .normal)
        
        collectionViewNextPage.register(UINib(nibName: "CollectionViewCellNextPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellNextPageCollectionViewCell")
    }
    
    private func showMainTabBar() {
        
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? UITabBarController {
            
            // Set as rootViewController
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
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
    
    func updateLabels(for index: Int) {
        let model = features[index]
        lblTitle.text = model.title
        lblDescription.text = model.subTitle
        pageControl.currentPage = index
        currentIndex = index
        btnDone.setTitle(index == features.count - 1 ? "Done" : "Next", for: .normal)
    }
}
