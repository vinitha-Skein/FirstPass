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
    let buttonBorder = UIColor(red: 233/255, green: 134/255, blue: 0/255, alpha: 1)

    var appointmentData:CreatedAppointmentData?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        patientName.text = appointmentData?.patientName
        doctorName.text = "Dr. " + (appointmentData?.doctorName ?? "")
        date.text = appointmentData?.date
        time.text = appointmentData?.appointmentTime
    }
    
    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
        
    }
    
    @IBAction func feedbackAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        backButton.createBorderForButton(cornerRadius: 5, borderWidth: 0, borderColor: .clear)
        feedbackButton.createBorderForButton(cornerRadius: 5, borderWidth: 0.5, borderColor: buttonBorder)
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
