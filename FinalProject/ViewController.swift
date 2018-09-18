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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //super.viewDidAppear(true)
        
        if let user = Auth.auth().currentUser{
            self.performSegue(withIdentifier: "toHomePageViewController", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signupBtn(_ sender: UIButton) {
        let signupUserViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        
        self.present(signupUserViewController, animated: true)
    }
    
    @IBAction func signinBtn(_ sender: UIButton) {
        let signinUserViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        self.present(signinUserViewController, animated: true)
    }
    
}

