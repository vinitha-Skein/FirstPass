//
//  ContactsViewController.swift
//  FirstPass
//
//  Created by Skeintech on 23/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var Branches = ["Branch 1","Branch 2","Branch 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "ContactsTableViewCell", bundle: .main), forCellReuseIdentifier: "ContactsTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    

}
extension ContactsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Branches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        cell.container.layer.cornerRadius = 10
        cell.branchLabel.text = Branches[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
