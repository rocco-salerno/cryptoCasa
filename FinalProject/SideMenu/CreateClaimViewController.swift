//
//  CreateClaimViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 12/6/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class CreateClaimViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var submitOutlet: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var claimTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTxt.delegate = self
        self.emailTxt.delegate = self
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        
        nameTxt.layer.borderWidth = 1
        nameTxt.layer.borderColor = UIColor.white.cgColor
        nameTxt.layer.cornerRadius = 20
        
        emailTxt.layer.borderWidth = 1
        emailTxt.layer.borderColor = UIColor.white.cgColor
        emailTxt.layer.cornerRadius = 20
        
        claimTxt.layer.borderWidth = 1
        claimTxt.layer.borderColor = UIColor.white.cgColor
        claimTxt.layer.cornerRadius = 20
        
        submitOutlet.layer.borderWidth = 1
        submitOutlet.layer.borderColor = UIColor.white.cgColor
        submitOutlet.layer.cornerRadius = 20
        
        
        sideMenu()
        
    }
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)                                          ///// to return keyboard
        return false
    }
}
