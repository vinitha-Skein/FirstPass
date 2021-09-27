//
//  FoodandBeveragesViewController.swift
//  FirstPass
//
//  Created by Skeintech on 25/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class FoodandBeveragesViewController: UIViewController {
    
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var breakfastButton: Mybutton!
    @IBOutlet weak var midmealsButton: Mybutton!
    @IBOutlet weak var dinnerButton: Mybutton!
    @IBOutlet weak var tableview: UITableView!
    
    var buttonBG = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
    var unselectedText = UIColor(red: 74/255, green: 79/255, blue: 87/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "FoodandBeveragesTableViewCell", bundle: .main), forCellReuseIdentifier: "FoodandBeveragesTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dinner_Clicked(_ sender: Any)
    {
        
         breakfastButton.backgroundColor = .clear
         midmealsButton.backgroundColor = .clear

         dinnerButton.backgroundColor = buttonBG
         dinnerButton.setTitleColor(.white, for: .normal)
         breakfastButton.setTitleColor(unselectedText, for: .normal)
         midmealsButton.setTitleColor(unselectedText, for: .normal)

    }
    
    @IBAction func breakfast_Clicked(_ sender: Any)
    {
        dinnerButton.backgroundColor = .clear
        midmealsButton.backgroundColor = .clear

        breakfastButton.backgroundColor = buttonBG
        breakfastButton.setTitleColor(.white, for: .normal)
        dinnerButton.setTitleColor(unselectedText, for: .normal)
        midmealsButton.setTitleColor(unselectedText, for: .normal)

    }
    
    @IBAction func midmeals_Click(_ sender: Any)
    {
        breakfastButton.backgroundColor = .clear
        dinnerButton.backgroundColor = .clear

        midmealsButton.backgroundColor = buttonBG
        midmealsButton.setTitleColor(.white, for: .normal)
        breakfastButton.setTitleColor(unselectedText, for: .normal)
        dinnerButton.setTitleColor(unselectedText, for: .normal)

    }
    @IBAction func requestWater_Clciked(_ sender: Any) {
    }
}
extension FoodandBeveragesViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodandBeveragesTableViewCell") as! FoodandBeveragesTableViewCell
        cell.quantityView.isHidden = true
        cell.quantityView.layer.borderWidth = 1
        cell.quantityView.layer.borderColor = UIColor.lightGray.cgColor
        cell.quantityView.layer.cornerRadius = 6
        cell.addClicked = {
            cell.addButton.isHidden = true
            cell.quantityView.isHidden = false

            
        }
        cell.increaseClicked = {
            var quantity = Int(cell.quantityLabel.text!)
            cell.quantityLabel.text = String(quantity!+1)
        }
        cell.DecreaseClicked = {
            var quantity = Int(cell.quantityLabel.text!)
            cell.quantityLabel.text = String(quantity!-1)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
}
