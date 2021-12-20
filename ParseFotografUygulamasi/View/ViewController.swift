//
//  ViewController.swift
//  ParseFotografUygulamasi
//
//  Created by İbrahim Güler on 25.07.2021.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    @IBAction func girisYapClicked(_ sender: Any) {
        if emailText.text != "" && sifreText.text != "" {
            PFUser.logInWithUsername(inBackground: emailText.text!, password: sifreText.text!) { user, error in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            self.hataMesaji(titleInput: "Hata", messageInput: "Lütfen Kullanıcı Adı veya Şifreyi Giriniz.")
        }
    }
    
    @IBAction func kayitOlClicked(_ sender: Any) {
        if emailText.text != "" && sifreText.text != "" {
            let user = PFUser()
            user.username = emailText.text
            user.password = sifreText.text
            
            user.signUpInBackground { success, error in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            self.hataMesaji(titleInput: "Hata", messageInput: "Lütfen Kullanıcı Adı veya Şifreyi Giriniz.")
        }
    }
    
    func hataMesaji(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

