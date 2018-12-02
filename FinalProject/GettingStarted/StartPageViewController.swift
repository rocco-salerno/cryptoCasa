//
//  ViewController.swift
//  FinalProject
//
//  Created by Rocco Salerno on 4/23/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var signupOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signupOutlet.layer.borderWidth = 1
        signupOutlet.layer.borderColor = UIColor.white.cgColor
        signupOutlet.layer.cornerRadius = 20
        
        loginOutlet.layer.borderWidth = 1
        loginOutlet.layer.borderColor = UIColor.white.cgColor
        loginOutlet.layer.cornerRadius = 20
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //super.viewDidAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

