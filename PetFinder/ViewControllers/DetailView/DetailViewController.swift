//
//  DetailViewController.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/12/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import SafariServices
import UIKit

// REAL ONE
class DetailViewController: UIViewController, MetaControllerConsumer {
    
    ///you know how it is
    var metaController: MetaController?
    
    @IBOutlet weak var largeImage: RemoteImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!

    @IBOutlet weak var openUrlButton: UIButton!
    
    let unknown = "Unknown"
    var pet: RealmPet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLog("Loaded Detail view")
        
        //load image from largest photo url
        largeImage.loadImage(urlString: pet?.fullPhoto,
                             defaultImage: UIImage(named: "bunny"))
        
        //set all the text labels
        nameLabel.text = pet?.name
        //twice the en/decoding for twice the fun
        detailLabel.text = pet?.detail?.html2String?.html2String
        ageLabel.text = pet?.age
        sexLabel.text = pet?.gender
        
        if pet?.phone == nil {
            phoneButton.isHidden = true
        } else {
            phoneButton.isHidden = false
        }
        title = pet?.name
    }
    
    /**
        Attempting to call number stored in pet.contact.phone
    */
    @IBAction func phoneButtonPressed(_ sender: UIButton) {
        if pet?.phone != nil {
            let justNumbers = pet?.phone?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            guard let url = URL(string: "tel://\(justNumbers ?? "")") else {
                
                alertUser(title: "Not Enough Bread", message: "Phone invalid -> Sorry, you can't get this bread.",
                          option: "No Days Off")
                warningLog("Invalid phone number for \(String(describing: pet?.idNum))")
                return
            }
            
            UIApplication.shared.open(url, options: [:]) { (success) in
                if !success {
                    self.alertUser(title: "Can't make phone call",
                                   message: "Sorry. Should wake up earlier.",
                                   option: "Keep hustling")
                }
            }
        } else {
            alertUser(title: "Not Enough Bread", message: "Phone invalid -> Sorry, you can't get this bread.",
                      option: "No Days Off")
            warningLog("Phone number data for \(String(describing: pet?.idNum)) is nil")
        }
    }
    
    func alertUser (title: String, message: String, option: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: option, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        return
    }
    
    /**
         Opens the link to the pet on PetFinder website for this
         pet. Uses SafariViewController do so.
     */
    @IBAction func openUrlButtonPressed() {
        guard let urlStr = pet?.url, let url = URL(string: urlStr) else {
            //TODO: alert user
            alertUser(title: "Can't open Url", message: "Don't lose the Hustle", option: "Try again tomorrow")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    }
        
}
