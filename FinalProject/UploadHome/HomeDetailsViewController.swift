//
//  HomeDetailsViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 9/30/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeDetailsViewController: UIViewController {
    
    var key:String = ""
    var firebaseReference: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackToPhotoUploadBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPhotoUpload", sender: self)
    }
    

}
