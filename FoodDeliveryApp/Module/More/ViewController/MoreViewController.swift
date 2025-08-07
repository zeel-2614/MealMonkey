//
//  MoreViewController.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 04/08/25.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var tblMoreItems: UITableView!
    var arrMoreItems: [MoreModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLeftAlignedTitle("More")
        self.setCartButton(target: self, action: #selector(cartButtonTapped))
        arrMoreItems = MoreModel.getMoreData()

        // Do any additional setup after loading the view.
        tblMoreItems.register(UINib(nibName: "MoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreTableViewCell")
    }
    
    @objc func cartButtonTapped() {
        print("Cart button tapped")
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMoreItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        let model = arrMoreItems[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "AboutStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .PayMent
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("First row selected")
        case 1:
            let storyboard = UIStoryboard(name: "AboutStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .MyOrders
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("Second row selected")
        case 2:
            print("Third row selected")
            let storyboard = UIStoryboard(name: "AboutStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .Notification
                self.navigationController?.pushViewController(plvc, animated: true)
            }
        case 3:
            let storyboard = UIStoryboard(name: "AboutStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .Inbox
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            
            print("fourth row selected")
        case 4:
            let storyboard = UIStoryboard(name: "AboutStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                plvc.objPagetype = .AboutUs
                self.navigationController?.pushViewController(plvc, animated: true)
            }
            print("fifth row selected")
        default:
            print("Other row selected")
        }
        
    }
}

enum PageType {
    case PayMent
    case MyOrders
    case Notification
    case Inbox
    case AboutUs
}
