//
//  AppointmentDetailsViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentDetailsViewController: UIViewController {

//    @IBOutlet weak var appointmentName: UILabel!
//    @IBOutlet weak var date: UILabel!
//    @IBOutlet weak var time: UILabel!
//    @IBOutlet weak var patientName: UILabel!
//    @IBOutlet weak var relationType: UILabel!
//    @IBOutlet weak var tableview: UITableView!
//    @IBOutlet weak var container: UIView!
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var patientDetailView: UIView!
//    @IBOutlet weak var cancelButton: UIButton!
//    @IBOutlet weak var ageLabel: UILabel!
    let viewModel = AppointmentDetailsViewModel()
    var appointmentData:ActiveAppointmentData?
    
    @IBOutlet weak var appointmentCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getUserDetails()
        
       
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
