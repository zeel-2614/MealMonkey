import UIKit

// MARK: - HomeTableViewCellDelegate
protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectProduct product: ProductModel)
    func homeTableViewCell(_ cell: HomeTableViewCell, didSelectCategory category: ProductCategory)
}

// MARK: - HomeTableViewCell
class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    weak var delegate: HomeTableViewCellDelegate?
    
    @IBOutlet weak var lblCollectionViewTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var collectionViewHome: UICollectionView!
    @IBOutlet weak var collectionViewHomeHeight: NSLayoutConstraint!
    
    enum CollectionType {
        case category
        case popular
        case mostPopular
        case RecentItems
    }
    
    var collectionType: CollectionType = .category
    var selectedCategory: ProductCategory = .All
    var categories: [ProductCategory] = [] {
        didSet {
            collectionViewHome.reloadData()
            DispatchQueue.main.async {
                self.collectionViewHome.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    var products: [ProductModel] = [] {
        didSet {
            collectionViewHome.reloadData()
            DispatchQueue.main.async {
                self.collectionViewHome.layoutIfNeeded()
                self.updateCollectionHeight()
            }
        }
    }
    
    func updateCollectionHeight() {
        if let layout = collectionViewHome.collectionViewLayout as? UICollectionViewFlowLayout,
           layout.scrollDirection == .vertical {
            self.collectionViewHomeHeight.constant = self.collectionViewHome.collectionViewLayout.collectionViewContentSize.height
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewHome.dataSource = self
        collectionViewHome.delegate = self
        
        collectionViewHome.register(UINib(nibName: Main.CellIdentifiers.homeCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Main.CellIdentifiers.homeCategoryCollectionViewCell)
        collectionViewHome.register(UINib(nibName: Main.CellIdentifiers.popularCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Main.CellIdentifiers.popularCollectionViewCell)
        collectionViewHome.register(UINib(nibName: Main.CellIdentifiers.mostPopularCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Main.CellIdentifiers.mostPopularCollectionViewCell)
        collectionViewHome.register(UINib(nibName: Main.CellIdentifiers.recentItemsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Main.CellIdentifiers.recentItemsCollectionViewCell)
        btnViewAll.setTitle(Main.homeAlert.viewAllButton, for: .normal)
        applyTheme()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction func btnViewAllClick(_ sender: Any) {
    }
}

// MARK: - UICollectionViewDataSource
extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionType {
        case .category:
            return categories.count
        default:
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionType {
        case .category:
            let cell: HomeCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Main.CellIdentifiers.homeCategoryCollectionViewCell, for: indexPath) as! HomeCategoryCollectionViewCell
            let category = categories[indexPath.row]
            cell.configure(with: category)
            cell.applyTheme()
            return cell
            
        case .popular:
            let cell: PopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Main.CellIdentifiers.popularCollectionViewCell, for: indexPath) as! PopularCollectionViewCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            cell.applyTheme()
            return cell
            
        case .mostPopular:
            let cell: MostPopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Main.CellIdentifiers.mostPopularCollectionViewCell, for: indexPath) as! MostPopularCollectionViewCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            cell.applyTheme()
            return cell
            
        case .RecentItems:
            let cell: RecentItemsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Main.CellIdentifiers.recentItemsCollectionViewCell, for: indexPath) as! RecentItemsCollectionViewCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            cell.applyTheme()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionType == .category {
            return CGSize(width: 88, height: 113)
        } else if collectionType == .popular {
            return CGSize(width: collectionViewHome.frame.width, height: 242.19)
        } else if collectionType == .mostPopular {
            return CGSize(width: 228, height: 185)
        } else if collectionType == .RecentItems {
            return CGSize(width: 296, height: 79)
        } else{
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionType {
        case .category:
            let selectedCategory = categories[indexPath.row]
            delegate?.homeTableViewCell(self, didSelectCategory: selectedCategory)
        default:
            let selectedProduct = products[indexPath.row]
            delegate?.homeTableViewCell(self, didSelectProduct: selectedProduct)
        }
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        // Cell background
        contentView.backgroundColor = theme.backgroundColor
        
        // Labels
        lblCollectionViewTitle.textColor = theme.labelTextColor
        btnViewAll.setTitleColor(theme.labelTextColor, for: .normal)
        
        // Collection view background
        collectionViewHome.backgroundColor = theme.backgroundColor
        
        // Optionally reload collection view cells to apply theme inside them
        collectionViewHome.reloadData()
    }
}
