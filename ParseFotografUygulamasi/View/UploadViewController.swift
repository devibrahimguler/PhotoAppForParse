//
//  UploadViewController.swift
//  ParseFotografUygulamasi
//
//  Created by İbrahim Güler on 25.07.2021.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yorumText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiSakla))
        view.addGestureRecognizer(keyboardRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        
        uploadButton.isEnabled = false
    
    }
    
    @objc func klavyeyiSakla(){
        view.endEditing(true)
    }
    
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        uploadButton.isEnabled = true
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        uploadButton.isEnabled = false
        
        let post = PFObject(className: "Post")
        if PFUser.current() != nil {
            if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
                let parseImage = PFFileObject(name: "image.jpg", data: data)
                post["kullanici"] = PFUser.current()!.username!
                post["yorum"] = yorumText.text!
                post["gorsel"] = parseImage
                
                post.saveInBackground { success, error in
                    if error != nil {
                        self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
                    } else {
                        self.yorumText.text = ""
                        self.imageView.image = UIImage(named: "fotosec")
                        self.tabBarController?.selectedIndex = 0
                        
                        NotificationCenter.default.post(name: NSNotification.Name("yeniPost"), object: nil)
                    }
                }
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
