//
//  DeleteFamilyMemberViewController.swift
//  FirstPass
//
//  Created by Skeintech on 11/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DeleteFamilyMemberViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var popup_container: UIView!
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
//        deleteButton.layer.cornerRadius = 8
//        popup_container.layer.cornerRadius = 10
//        container.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_Pressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func delete_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
