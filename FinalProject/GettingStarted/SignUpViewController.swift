//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by Rocco Salerno on 4/27/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate, UIApplicationDelegate {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var submitOutlet: UIButton!
    
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var emailAddressTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var retypePasswordTxtField: UITextField!
    
    var ref: DatabaseReference!
    
/////////////////////////////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        self.retypePasswordTxtField.delegate = self;
        self.passwordTxtField.delegate = self;
        self.emailAddressTxtField.delegate = self;
        
        emailAddressTxtField.layer.borderWidth = 1
        emailAddressTxtField.layer.borderColor = UIColor.white.cgColor
        emailAddressTxtField.layer.cornerRadius = 20
        
        passwordTxtField.layer.borderWidth = 1
        passwordTxtField.layer.borderColor = UIColor.white.cgColor
        passwordTxtField.layer.cornerRadius = 20
        
        retypePasswordTxtField.layer.borderWidth = 1
        retypePasswordTxtField.layer.borderColor = UIColor.white.cgColor
        retypePasswordTxtField.layer.cornerRadius = 20
        
        submitOutlet.layer.borderWidth = 1
        submitOutlet.layer.borderColor = UIColor.white.cgColor
        submitOutlet.layer.cornerRadius = 20
        
        cancelOutlet.layer.borderWidth = 1
        cancelOutlet.layer.borderColor = UIColor.white.cgColor
        cancelOutlet.layer.cornerRadius = 20
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////

    @IBAction func submitSignupBtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Success!", message: "You Have Created An Account", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Proceed", style: .default, handler:  { action in self.performSegue(withIdentifier: "SignInViewController", sender: self)}))
        
        if(emailAddressTxtField.text?.isEmpty)! || (passwordTxtField.text?.isEmpty)! || (retypePasswordTxtField.text?.isEmpty)!
        {
            //display an alert message empty field
            displayAlertMessage(userMessage: "You Are Missing Fields")
            return
        }
        
        if (passwordTxtField.text != retypePasswordTxtField.text)
        {
            //display alert message Nonmatching password
            displayAlertMessage(userMessage: "Your Password Does Not Match")
        }
        else{
            //everything is good, SEND IT TO THE DATABASE !
            Auth.auth().createUser(withEmail: emailAddressTxtField.text!, password: passwordTxtField.text!) {user, error in
                if error == nil && user != nil{
                    print("user created!")
                    let alert = UIAlertController(title: "Success!", message: "Your Account Was Created!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title:"Proceed", style: .default, handler:  { action in self.performSegue(withIdentifier: "toLoginPage", sender: self)}))
                    self.present(alert, animated: true, completion: nil)
                }else
                {
                    print("Error creating user: \(error?.localizedDescription)")
                }
            }
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////

    @IBAction func cancelSignupBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
/////////////////////////////////////////////////////////////////////////////////////////////////////

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
/////////////////////////////////////////////////////////////////////////////////////////////////////

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////

}
