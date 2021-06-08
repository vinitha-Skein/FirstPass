//
//  AlertNotificationViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 14/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AlertNotificationViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableview:UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                   overrideUserInterfaceStyle = .light
               } 
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        tableview.register(UINib(nibName: "AlertTableCell", bundle: .main), forCellReuseIdentifier: "AlertTableCell")
        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "FamilyMemberViewController") as! FamilyMemberViewController
//        vc.modalPresentationStyle = .fullScreen
        dismiss(animated: true, completion: nil)
        
    }

}


extension AlertNotificationViewController:UITableViewDelegate,UITableViewDataSource{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 120
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableCell", for: indexPath) as! AlertTableCell
        if indexPath.row == 0 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception area. We are looking forward to seeing you at the facility"
            cell.notificationTime.text = "Just now"
        }else if indexPath.row == 1 {
        cell.notificationMessage.text = "Your personal concierge Mr Adam will meet you Near the reception area. You can call him on +9715544@@"
            cell.notificationTime.text = "1 Day ago"
        }else if indexPath.row == 2 {
        cell.notificationMessage.text = "Your parking slot P-31 at level 1 is booked for car plate number R-1605.           Please use gate number 2                    "
            cell.notificationTime.text = "2 Day ago"
        }else if indexPath.row == 3 {
        cell.notificationMessage.text = "You can now avail pre checking services like valet parking, Concierge services and VIP upgrade for your scheduled appointment with   Dr Albert from the mobile app"
            cell.notificationTime.text = "3 Day ago"
        }
            return cell
       
    }
    
    
}
