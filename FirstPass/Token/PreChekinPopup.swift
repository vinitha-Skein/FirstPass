//
//  PreChekinPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class PreChekinPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var carPlate: UIView!
    
    
    @IBOutlet weak var caarparking: NSLayoutConstraint!
    
    @IBOutlet weak var vipService: NSLayoutConstraint!
    
    @IBOutlet weak var carparkingView: UIView!
    @IBOutlet weak var convergePreference: UIView!
    @IBOutlet weak var convergeLanguage: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var parkingYes: UIImageView!
    @IBOutlet weak var parkingNo: UIImageView!
    @IBOutlet weak var specialAssistanceYes: UIImageView!
    @IBOutlet weak var specialAssistanceNo: UIImageView!
    @IBOutlet weak var vipServiceYes: UIImageView!
    @IBOutlet weak var vipServiceNo: UIImageView!
    
    @IBOutlet weak var vipPreServiceYes: UIImageView!
     @IBOutlet weak var vipPreServiceNo: UIImageView!
    
    @IBOutlet weak var vipLanServiceYes: UIImageView!
     @IBOutlet weak var vipLanServiceNo: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        container.layer.cornerRadius = 25
        submitButton.layer.cornerRadius = 8
        cancelButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)
        // Do any additional setup after loading the view.
    }
    @IBAction func radioButtonYes(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            parkingYes.image = UIImage(named: "radioSelected")
            parkingNo.image = UIImage(named: "radioDeselected")
            carPlate.isHidden=false;
            caarparking.constant=200;
            
        case 2:
            specialAssistanceYes.image = UIImage(named: "radioSelected")
            specialAssistanceNo.image = UIImage(named: "radioDeselected")
        default:
            vipServiceYes.image = UIImage(named: "radioSelected")
            vipServiceNo.image = UIImage(named: "radioDeselected")
            convergePreference.isHidden=false;
            convergeLanguage.isHidden=false;
            vipService.constant = 270;
            
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func radioButtonNo(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            parkingYes.image = UIImage(named: "radioDeselected")
            parkingNo.image = UIImage(named: "radioSelected")
             carPlate.isHidden=true;
             caarparking.constant=110;
        case 2:
            specialAssistanceYes.image = UIImage(named: "radioDeselected")
            specialAssistanceNo.image = UIImage(named: "radioSelected")
        default:
            vipServiceYes.image = UIImage(named: "radioDeselected")
            vipServiceNo.image = UIImage(named: "radioSelected")
            convergePreference.isHidden=true;
            convergeLanguage.isHidden=true;
            vipService.constant = 110;
        }

    }
    @IBAction func submitAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
