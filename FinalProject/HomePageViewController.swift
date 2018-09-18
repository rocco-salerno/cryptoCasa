//
//  HomePageViewController.swift
//  FinalProject
//
//  Created by Rocco Salerno on 4/27/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomePageViewController: UIViewController {
var myStringValue : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutBtn(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        let signOut = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(signOut, animated: true)
    }
    


}
