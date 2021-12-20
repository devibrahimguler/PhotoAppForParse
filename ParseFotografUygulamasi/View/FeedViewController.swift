//
//  FeedViewController.swift
//  ParseFotografUygulamasi
//
//  Created by İbrahim Güler on 25.07.2021.
//

import UIKit
import Parse

class FeedViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postDizisi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
 
        veriAl()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(veriAl), name: NSNotification.Name("yeniPost"), object: nil)
    }
    @objc func veriAl(){
        let quary = PFQuery(className: "Post")
        quary.addDescendingOrder("createdAt")
        quary.findObjectsInBackground { objects, error in
            if error != nil {
                self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata")
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        self.postDizisi.removeAll(keepingCapacity: false)
                        for object in objects! {
                            if let kullanici = object.object(forKey: "kullanici") as? String {
                                if let yorum = object.object(forKey: "yorum") as? String {
                                    if let gorsel = object.object(forKey: "gorsel") as? PFFileObject {
                                        let post = Post(kullanici: kullanici, yorum: yorum, gorsel: gorsel)
                                        self.postDizisi.append(post)
                                    }
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        postDizisi[indexPath.row].gorsel.getDataInBackground { data, error in
            if error == nil {
                if let data = data {
                    cell.postEmailText.text = self.postDizisi[indexPath.row].kullanici
                    cell.postYorumText.text = self.postDizisi[indexPath.row].yorum
                    cell.postImageView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    func hataMesaji(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
