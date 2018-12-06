//
//  CreateClaimViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 12/6/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class CreateClaimViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        
    }
    
    func sideMenu()
    {
        if revealViewController != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            revealViewController()?.rightViewRevealWidth = 160
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
    }
}
