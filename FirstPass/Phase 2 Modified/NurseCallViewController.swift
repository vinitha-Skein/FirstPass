//
//  NurseCallViewController.swift
//  FirstPass
//
//  Created by Skeintech on 24/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class NurseCallViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var icons = ["toilet-sanitization","Clinical Assistance","massage-therapi","General Request"]
    var activities = ["Request Urinal assistance","Request Clinical Assistance","Request massage/therapist","General Request"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "NurseTableViewCell", bundle: .main), forCellReuseIdentifier: "NurseTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self

    
        // Do any additional setup after loading the view.
    }
    

    

}
extension NurseCallViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NurseTableViewCell") as! NurseTableViewCell
        cell.iconImage.image = UIImage(named: icons[indexPath.row])
        cell.activityText.text = activities[indexPath.row]
        cell.container.layer.cornerRadius = 8
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Enter")
//        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "NurseandHygienePopupViewController") as! NurseandHygienePopupViewController
//        vc.Nurse = true
//
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
