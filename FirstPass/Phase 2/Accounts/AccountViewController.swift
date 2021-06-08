//
//  AccountViewController.swift
//  FirstPass
//
//  Created by Skeintech on 08/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    var categories = ["My Profile","My Appointments","Book Appointment","Payments","Reports","Indoor Map","Chat with Us","Logout"]
    var logoImages = ["accountpic","appointments","book","payments","reports","map","chat","logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func notification_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertNotificationViewController") as! AlertNotificationViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Scanner_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        present(vc, animated: true, completion: nil)
    }
    

}
extension AccountViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell", for: indexPath) as! AccountCollectionViewCell
        cell.categoryLabel.text = categories[indexPath.row]
        cell.logoImage.image = UIImage(named: logoImages[indexPath.row])
        cell.container.layer.cornerRadius = 20
        cell.container.layer.borderWidth = 0.2
        cell.container.layer.borderColor = UIColor.lightGray.cgColor
        cell.container.layer.masksToBounds = false
        cell.container.layer.shadowColor = UIColor.lightGray.cgColor
        cell.container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.container.layer.shadowOpacity = 0.2

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionview.frame.width/2)-16
        
        return  CGSize(width: 156, height: 146)
    }
    
}
