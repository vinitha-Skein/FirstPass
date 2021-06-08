//
//  MyAppointmentsViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class MyAppointmentsViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var activeAppointments: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    let viewModel = MyAppointmentsViewModel()
    var userId = Int()
    var appointmentArray = ["Orthopedic replacement","Medicine collections","Orthopedic replacement"]
    var isActiveAppointment = Bool()
    var dummyAppointments = [ActiveAppointmentData]()
    var blurView = UIView()
    var checkInView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableview.register(UINib(nibName: "AppointmentTableViewCell", bundle: .main), forCellReuseIdentifier: "AppointmentTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        isActiveAppointment = true
        // Do any additional setup after loading the view.
   //     fetchActiveAppointments()
        
        
        //For demo purpose
        let appointment1 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Cardiology", serviceName: "Cardiology", appointmentTime: "2021-01-06 15:00:00", serviceBookedId: 0, status: "")
        let appointment2 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Internal Medicine", serviceName: "Internal Medicine", appointmentTime: "2021-01-06 16:00:00", serviceBookedId: 0, status: "")
        let appointment3 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Laboratory", serviceName: "Laboratory", appointmentTime: "2021-01-06 16:30:00", serviceBookedId: 0, status: "")
        dummyAppointments = [appointment1,appointment2,appointment3]
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func activeAppointmentAction(_ sender: Any) {
        activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .lightGray)
        historyButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
        historyButton.backgroundColor = .clear
        activeAppointments.backgroundColor = .white
        isActiveAppointment = true
      //  fetchActiveAppointments()
        self.tableview.reloadData()
    }
    @IBAction func historyAction(_ sender: Any) {
        historyButton.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .lightGray)
        activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
        activeAppointments.backgroundColor = .clear
        historyButton.backgroundColor = .white
        isActiveAppointment = false
    //    fetchAllAppointments()
        self.tableview.reloadData()
    }
    @IBAction func bookAppointmentAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
        vc.modalPresentationStyle = .fullScreen
        vc.isNeedBackButton = true
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    func setupUI(){
        activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .lightGray)
        historyButton.backgroundColor = .clear
        activeAppointments.backgroundColor = .white
        bookButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
    }
    func fetchActiveAppointments(){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.fetchUpcomingAppointments(userId: userId)
        
        viewModel.fetchActiveSuccess = {
            self.tableview.reloadData()
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
    func fetchAllAppointments(){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.fetchAllAppointments(userId: userId, page: 1)
        
        viewModel.fetchAllSuccess = {
            self.tableview.reloadData()
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

extension MyAppointmentsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isActiveAppointment{
//            return viewModel.activeAppointments?.appointmentDetails?.count ?? 0
//        }else{
//            return viewModel.allAppointments?.appointmentDetails?.count ?? 0
//        }
        return dummyAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
        cell.delegate = self
        cell.updateBackgroundColorUI(indexPath: indexPath)
        if isActiveAppointment{
//            cell.updateAppointmentDataToUI(data: (viewModel.activeAppointments?.appointmentDetails?[indexPath.row])!, indexpath: indexPath)
        cell.updateAppointmentDataToUI(data: (dummyAppointments[indexPath.row]), indexpath: indexPath)
        }else{
            cell.checkinButton.isHidden = true
//            cell.updateAppointmentDataToUI(data: (viewModel.allAppointments?.appointmentDetails?[indexPath.row])!, indexpath: indexPath)
        cell.updateAppointmentDataToUI(data: (dummyAppointments[indexPath.row]), indexpath: indexPath)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    
}


extension MyAppointmentsViewController:CheckInDelegate{
    func appointmentArrived(appointmentIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ArrivedPopup") as! ArrivedPopup
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func appointmentParking(appointmentIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ParkingMapPopup") as! ParkingMapPopup
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func appointmentPreCheckIn(appointmentIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PreChekinPopup") as! PreChekinPopup
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func appointmentCheckIn(appointmentIndex: Int) {
        createBlurView()
//        createCheckIn(appointmentName: viewModel.appointmentData?.appointmentDetails?[appointmentIndex].serviceName ?? "")
        NSLog("Tag------->%d", appointmentIndex)
        createCheckIn(appointmentName: dummyAppointments[appointmentIndex].serviceName ?? "")
    }
    
    func appointmentIndoorMap(appointmentIndex: Int) {
        
    }
}


extension MyAppointmentsViewController{
    func createBlurView(){
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = UIColor(red: 28.0/255.0, green: 29.0/255.0, blue: 48.0/255, alpha: 0.8)
        //        blurView.alpha = 0.8
        view.addSubview(blurView)
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        blurView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
        blurView.addGestureRecognizer(gesture)
    }
    @objc func closePopUp(){
        
    }
    @objc func checkInAppointmentAction(){
        blurView.removeFromSuperview()
        for view in checkInView.subviews{
            view.removeFromSuperview()
        }
        checkInView.removeFromSuperview()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    @objc func cancelCheckInAction(){
        blurView.removeFromSuperview()
        checkInView.removeFromSuperview()
        for view in checkInView.subviews{
            view.removeFromSuperview()
        }
    }
    
    //Password change Success POPUP view
    func createCheckIn(appointmentName:String){
        createBlurView()
        checkInView.layer.cornerRadius = 30
        checkInView.backgroundColor = UIColor(hexString: "#fbfbfb")
        view.addSubview(checkInView)
        
        checkInView.translatesAutoresizingMaskIntoConstraints = false
        checkInView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        checkInView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        checkInView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.createBorderForButton(cornerRadius: 10, borderWidth: 1, borderColor: .black)
        cancelButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        cancelButton.addTarget(self, action: #selector(cancelCheckInAction), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 10
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        checkInView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: checkInView.leadingAnchor,constant: 30).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: checkInView.trailingAnchor,constant: -30).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: checkInView.bottomAnchor,constant: -20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let checkInButton = UIButton()
        checkInButton.setTitle("Check in", for: .normal)
        checkInButton.setTitleColor(.white, for: .normal)
        checkInButton.backgroundColor = UIColor(hexString: Colors.buttonColor)
        checkInButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        checkInButton.addTarget(self, action: #selector(checkInAppointmentAction), for: .touchUpInside)
        checkInButton.layer.cornerRadius = 10
        checkInButton.translatesAutoresizingMaskIntoConstraints = false
        checkInView.addSubview(checkInButton)
        checkInButton.leadingAnchor.constraint(equalTo: checkInView.leadingAnchor,constant: 30).isActive = true
        checkInButton.trailingAnchor.constraint(equalTo: checkInView.trailingAnchor,constant: -30).isActive = true
        checkInButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor,constant: -20).isActive = true
        checkInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        
        let label = UILabel()
        label.text = "are you sure you want to check in, " + appointmentName
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = UIColor(hexString: "#35373a")
        label.textAlignment = .center
        //        label.backgroundColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        checkInView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: checkInView.leadingAnchor,constant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: checkInView.trailingAnchor,constant: -30).isActive = true
        label.bottomAnchor.constraint(equalTo: checkInButton.topAnchor,constant: -40).isActive = true
        label.topAnchor.constraint(equalTo: checkInView.topAnchor,constant: 30).isActive = true
    }
    
}
