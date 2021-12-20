//
//  SettingsViewController.swift
//  ParseFotografUygulamasi
//
//  Created by İbrahim Güler on 25.07.2021.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cikisYapClicked(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil {
                self.hataMesaji(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata!")
            } else {
                self.performSegue(withIdentifier: "toLoginVC", sender: nil)
            }
        }
    }
    
    func hataMesaji(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
