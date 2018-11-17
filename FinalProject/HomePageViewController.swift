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
    
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func signOutBtn(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard{
            let vc = storyboard.instantiateViewController(withIdentifier: "StartPage")
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    
    
    
    func sideMenu()
    {
        if revealViewController != nil {
            menuButtonOutlet.target = revealViewController()
            menuButtonOutlet.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            revealViewController()?.rightViewRevealWidth = 160
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
    }
    
}
