//
//  uploadHomeViewController.swift
//  Login_Register
//
//  Created by Gibriel Spiteri on 9/18/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class uploadHomeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var homeTypeOutlet: UIPickerView!
    
    let homeTypes = ["Ranch", "Split Level", "Victorian","Condo", "Duplex", "Penthouse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkFields() {
        if (nameLabel.text != nil && addressLabel.text != nil && phoneNumberLabel.text != nil)
        {
            
        }
    }
    

}
