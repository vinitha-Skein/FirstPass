//
//  AppointmentDetailsViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentDetailsViewController: UIViewController {

    @IBOutlet weak var appointmentName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var relationType: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var patientDetailView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    let viewModel = AppointmentDetailsViewModel()
    var appointmentData:ActiveAppointmentData?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableview.register(UINib(nibName: "AppointmentDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "AppointmentDetailsTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
        viewModel.getUserDetails()
        appointmentName.text = appointmentData?.serviceName
        let convertedDate = self.getAppointmentDateTime(date: appointmentData?.appointmentTime ?? "", format: "yyyy-MM-dd HH:mm:ss", requiredFormat: "yyyy-MM-dd")
        let convertedTime = self.getAppointmentDateTime(date: appointmentData?.appointmentTime ?? "", format:"yyyy-MM-dd HH:mm:ss" , requiredFormat: "h:mm:a")
        date.text = convertedDate
        time.text = convertedTime
        if appointmentData?.pId == viewModel.pId{
            patientDetailView.isHidden = true
        }
        if appointmentData?.status == "CANCELLED"{
            cancelButton.isHidden = true
        }
    }

    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
        vc.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
//        present(vc, animated: true)
        dismiss(animated: true, completion: nil)


    }
    @IBAction func cancelAction(_ sender: Any) {
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.cancelAppointment(appointmentId: appointmentData?.serviceBookedId ?? 0)
        viewModel.cancelSuccess = {
            self.showAlert("Appointment Cancelled")
            self.cancelButton.isHidden = true
        }
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    
   func setupUI(){
            cancelButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
            container.clipsToBounds = true
            container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
    let attributedString = NSMutableAttributedString(string: "Age: 65 years", attributes: [
      .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
      .foregroundColor: UIColor(red: 154.0 / 255.0, green: 155.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0),
      .kern: 0.0
    ])
    attributedString.addAttributes([
      .font: UIFont.systemFont(ofSize: 14.0, weight: .bold),
      .foregroundColor: UIColor(red: 53.0 / 255.0, green: 54.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0)
    ], range: NSRange(location: 0, length: 4))
    ageLabel.attributedText = attributedString
        }
    }

    extension AppointmentDetailsViewController:UITableViewDelegate,UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailsTableViewCell", for: indexPath) as! AppointmentDetailsTableViewCell
            cell.updateBackgroundColorUI(indexPath: indexPath)
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 135
        }
        
        
    }
