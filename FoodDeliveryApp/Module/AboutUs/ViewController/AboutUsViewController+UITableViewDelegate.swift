//
//  AboutUsViewController+UITableViewDelegate.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 05/08/25.
//

import Foundation
import UIKit

extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCurrent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell : AboutUsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AboutUsTableViewCell", for: indexPath) as! AboutUsTableViewCell
        
        switch objPagetype {
        case .AboutUs:
            cell.configaboutcell(about: arrCurrent[indexPath.row])
        case .Notification:
            cell.configNotificationcell(about: arrCurrent[indexPath.row])
        case .Inbox:
            cell.configInboxcell(about: arrCurrent[indexPath.row])
        default:
            break
        }
        return cell
    }
}

