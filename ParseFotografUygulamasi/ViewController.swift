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
        
    performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    @IBAction func kayitOlClicked(_ sender: Any) {
    }
    
}

