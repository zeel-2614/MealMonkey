import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var tblMoreOpions: UITableView!
    
    var arrCurrent: [AboutModel] = []
    var objPageType: PageType = .AboutUs

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        switch objPageType {
        
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
            setLeftAlignedTitleWithBack("Notifications", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartTapped))
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
            setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartTapped))
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
            setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartTapped))
        }
        tblMoreOpions.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
 
    @objc private func cartTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
