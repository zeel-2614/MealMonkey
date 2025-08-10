import UIKit

class DessertsViewController: UIViewController {

    @IBOutlet weak var txtSearchDesserts: UITextField!
    @IBOutlet weak var tblDesserts: UITableView!
    
    var arrDessert: [DessertsModel] = DessertsModel.addDesserts()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewStyle(cornerRadius: txtSearchDesserts.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchDesserts])
        
        setPadding(textfield: [txtSearchDesserts])
        
        setLeftAlignedTitleWithBack("Desserts", target: self, action: #selector(dessertBackBtn))
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        tblDesserts.register(UINib(nibName: "DessertsTableViewCell", bundle: nil), forCellReuseIdentifier: "DessertsTableViewCell")
    }
    
    @objc func dessertBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCartTapped() {
        
    }
    
    func setPadding(textfield: [UITextField]){
        
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
}
