//
//  SignInViewController.swift
//  FinalProject
//
//  Created by Rocco Salerno on 4/27/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import LocalAuthentication


class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userPasswordTxtField: UITextField!
    @IBOutlet weak var userEmailAddressTxtField: UITextField!
    
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var backOutlet: UIButton!
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        self.userEmailAddressTxtField.delegate = self
        self.userPasswordTxtField.delegate = self
        
        userPasswordTxtField.layer.borderWidth = 1
        userPasswordTxtField.layer.borderColor = UIColor.white.cgColor
        userPasswordTxtField.layer.cornerRadius = 15
        
        userEmailAddressTxtField.layer.borderWidth = 1
        userEmailAddressTxtField.layer.borderColor = UIColor.white.cgColor
        userEmailAddressTxtField.layer.cornerRadius = 15
        
        loginOutlet.layer.borderWidth = 1
        loginOutlet.layer.borderColor = UIColor.white.cgColor
        loginOutlet.layer.cornerRadius = 15
        
        backOutlet.layer.borderWidth = 1
        backOutlet.layer.borderColor = UIColor.white.cgColor
        backOutlet.layer.cornerRadius = 15
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }

    @IBAction func signinSubmit(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: userEmailAddressTxtField.text!, password: userPasswordTxtField.text!){ user, error in
            if error == nil && user != nil
            {
                self.performSegue(withIdentifier: "toHomeScreenPage", sender: self)
            }else{
                let alert = UIAlertController(title: "Login Error", message: "You have entered an incorrect email or password", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Error logging in: \(error!.localizedDescription)")
            }
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////

    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func faceIDBtn(_ sender: UIButton) {
        let context: LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Biometrics", reply: {(wasCorrect, error)in
                if wasCorrect
                {
                    let signUpComplete = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                    self.present(signUpComplete, animated: true)
                }
                else
                {
                    print("incorrect")
                }
            })
        }
        else{
            print("error")
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)                                          ///// to return keyboard
        return false
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////
}
