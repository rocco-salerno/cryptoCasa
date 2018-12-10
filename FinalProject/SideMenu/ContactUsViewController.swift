//
//  ContactUsViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 12/5/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var menuBtnOutlet: UIBarButtonItem!
    @IBOutlet weak var contactFormTxt: UITextView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var submitOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borders()
        sideMenu()
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        
    }
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }

    @IBAction func submitBtn(_ sender: UIButton) {
        sendEnmail()
    }
    
    
    func borders()
    {
        nameTxt.layer.borderWidth = 1
        nameTxt.layer.borderColor = UIColor.white.cgColor
        nameTxt.layer.cornerRadius = 15
        
        contactFormTxt.layer.borderWidth = 1
        contactFormTxt.layer.borderColor = UIColor.white.cgColor
        contactFormTxt.layer.cornerRadius = 15
        
        submitOutlet.layer.borderWidth = 1
        submitOutlet.layer.borderColor = UIColor.white.cgColor
        submitOutlet.layer.cornerRadius = 15
    }

    func sendEnmail()
    {
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Contact us")
            mail.setToRecipients(["cryptoCasaClaims@gmail.com"])
            mail.setMessageBody("<h4>Hello, \(nameTxt.text!).  If your message looks okay, go ahead and send it away. </h4><p>\(contactFormTxt.text!)</p>", isHTML: true)
            
            present(mail, animated: true)
        }
        else
        {
            print("error with mail")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func sideMenu()
    {
        if revealViewController != nil {
            menuBtnOutlet.target = revealViewController()
            menuBtnOutlet.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            revealViewController()?.rightViewRevealWidth = 160
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
    }
}
