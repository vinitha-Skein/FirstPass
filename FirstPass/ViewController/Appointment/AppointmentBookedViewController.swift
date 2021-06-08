//
//  AppointmentBookedViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 23/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentBookedViewController: UIViewController,FeedbackDelegate {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!


    var appointmentData:CreatedAppointmentData?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        patientName.text = appointmentData?.patientName
        doctorName.text = "Dr. " + (appointmentData?.doctorName ?? "")
        date.text = appointmentData?.appointmentTime
        time.text = "03:00 PM"
    }
    
    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func feedbackAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
        popup.modalPresentationStyle = .overCurrentContext
        popup.delegate = self
        present(popup, animated: true, completion: nil)
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 32, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        backButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        feedbackButton.createBorderForButton(cornerRadius: 8, borderWidth: 0.5, borderColor: .black)
    }
    func feedbackAddStatus(status: Bool, message: String) {
        self.dismiss(animated: true, completion: nil)
        if status{
            self.showAlert(message)
        }
    }

}


protocol FeedbackDelegate {
    func feedbackAddStatus(status:Bool,message:String)
}
