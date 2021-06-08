//
//  FamilyMemberViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FamilyMemberViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var addButton: UIButton!
    let viewModel = FamilyMemberViewModel()
    var familyMemberData = [FamilyMembersList]()
    var userId = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "FamilyMemberTableViewCell", bundle: .main), forCellReuseIdentifier: "FamilyMemberTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        setupUI()
        viewModel.getUserDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
//        fetchFamilyMembers()
        let myself = FamilyMembersList(name: "Mrs. Natasha", dob: "04-03-1960", memberId: 0, pId: 0, releation: "Self", title: "Mrs", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "456878563", profile_pic: "")
        let member1 = FamilyMembersList(name: "Mr. Mr. Johnsmith", dob: "18-08-1956", memberId: 0, pId: 0, releation: "Husband", title: "Mrs", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "998878563", profile_pic: "")
        let member2 = FamilyMembersList(name: "Mr. Johnathan", dob: "07-11-1985", memberId: 0, pId: 0, releation: "Son", title: "Mr", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "678878563", profile_pic: "")
        familyMemberData = [myself,member1,member2]
    }

    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        view.window!.layer.add(leftToRightTransition(), forKey: kCATransition)
        //                present(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMemberAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
        vc.modalPresentationStyle = .fullScreen
        vc.userId = userId
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        addButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        
    }
    
    func fetchFamilyMembers(){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.fetchFamilyMember(userId: viewModel.userId ?? 0)
        viewModel.dataFetchSuccess = {
            self.familyMemberData = self.viewModel.familyMemberData ?? []
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
    }
}


extension FamilyMemberViewController:UITableViewDelegate,UITableViewDataSource,EditFamilyMemberDelegate{
    func editFamilyMember(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
        vc.modalPresentationStyle = .fullScreen
        vc.isEdit = true
//        vc.familyMember = viewModel.familyMemberData![index]
        vc.userId = userId
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyMemberData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMemberTableViewCell", for: indexPath) as! FamilyMemberTableViewCell
//        cell.updateData(data: viewModel.familyMemberData![indexPath.row])
        cell.updateData(data: familyMemberData[indexPath.row])
        cell.editButton.tag = indexPath.row
        cell.delegate = self
//        cell.imageUrl = viewModel.familyMemberData![indexPath.row].profile_pic
        let users = ["user2","user1","user3"]
        cell.pic.image = UIImage(named: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}



protocol EditFamilyMemberDelegate {
    func editFamilyMember(index:Int)
}
