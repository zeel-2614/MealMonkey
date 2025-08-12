import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var tblMoreOpions: UITableView!
    
    var arrCurrent: [AboutModel] = []
    var objPageType: PageType = .AboutUs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        switch objPageType {
        case .PayMent:
            print("Payment")
        case .MyOrders:
            print("My Orders")
        case .Notification:
            arrCurrent = AboutModel.addNotificationData()
            setLeftAlignedTitleWithBack("Notifications", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartNotificationsTapped))
        case .Inbox:
            arrCurrent = AboutModel.addInboxData()
            setLeftAlignedTitleWithBack("Inbox", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartInboxTapped))
        case .AboutUs:
            arrCurrent = AboutModel.addAboutData()
            setLeftAlignedTitleWithBack("About Us", target: self, action: #selector(backButtonTapped))
            setCartButton(target: self, action: #selector(cartAboutUsTapped))
        }
        
        tblMoreOpions.register(UINib(nibName: "AboutUsTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutUsTableViewCell")
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cartPaymentTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @objc func cartMyOrdersTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @objc func cartNotificationsTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @objc func cartInboxTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
    
    @objc func cartAboutUsTapped() {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let menuVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(menuVC, animated: true)
        }
    }
}
