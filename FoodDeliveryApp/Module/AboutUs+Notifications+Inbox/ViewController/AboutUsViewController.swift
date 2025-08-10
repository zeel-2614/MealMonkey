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
        
    }
    
    @objc func cartMyOrdersTapped() {
        
    }
    
    @objc func cartNotificationsTapped() {
        
    }
    
    @objc func cartInboxTapped() {
        
    }
    
    @objc func cartAboutUsTapped() {
        
    }
}
