//
//  WalletIDViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 12/9/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class WalletIDViewController: UIViewController {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var submitOutlet: UIButton!
    
    var firebaseReference:DatabaseReference?
    var userIDKey = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorThings()
        sideMenu()
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }

    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        firebaseReference = Database.database().reference().child("Wallets")
        
        if( nameText.text! != "")
        {
            firebaseReference?.child(userIDKey).child("Wallet").setValue(["WalletID": nameText.text!])
            
            let alert = UIAlertController(title: "Success!", message: "You Added A Wallet!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"Proceed", style: .default, handler:  { action in self.performSegue(withIdentifier: "backToTheHomePageWeGo", sender: self)}))
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
             displayAlertMessage(userMessage: "You need to enter a Wallet!")
        }
        
    }
    
    func displayAlertMessage(userMessage: String)->Void
    {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"We have a Problem", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction!) in DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func colorThings()
    {
        nameText.layer.cornerRadius = 15
        nameText.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nameText.layer.borderWidth = 1
        
        submitOutlet.layer.cornerRadius = 15
        submitOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        submitOutlet.layer.borderWidth = 1
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
