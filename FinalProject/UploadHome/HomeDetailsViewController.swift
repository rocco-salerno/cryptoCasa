//
//  HomeDetailsViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 9/30/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController {

    var name:String = ""
    var address:String = ""
    var city:String = ""
    var state:String = ""
    var zipcode:String = ""
    var phonenumber:String = ""
    var hometype:String = ""
    var walletid:String = ""
    var price:String = ""
    var photoid: String = ""
    var details: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackToPhotoUploadBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPhotoUpload", sender: self)
    }
    

}
