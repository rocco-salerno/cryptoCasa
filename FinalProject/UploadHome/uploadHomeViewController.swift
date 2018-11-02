//
//  uploadHomeViewController.swift
//  Login_Register
//
//  Created by Gibriel Spiteri on 9/18/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import FirebaseDatabase

class uploadHomeViewController: UIViewController, UITextFieldDelegate {
    var key:String = ""
    var firebaseReference:DatabaseReference?
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var phoneNumberLabel: UITextField!
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var stateLabel: UITextField!
    @IBOutlet weak var zipcodeLabel: UITextField!
    
    var name: String = ""
    var address: String = ""
    var phonenumber: String = ""
    var city: String = ""
    var state: String = ""
    var zipcode: String = ""
    var hometype: String = ""
    
    
    @IBOutlet weak var homeTypeOutlet: UIPickerView!
    @IBOutlet weak var homeTypeFromPicker: UITextField!
    
    private let homeTypes = ["Ranch", "Split Level", "Victorian","Condo", "Duplex", "Penthouse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseReference = Database.database().reference().child("Customers")
        
        self.nameLabel.delegate = self
        self.addressLabel.delegate = self
        self.cityLabel.delegate = self
        self.stateLabel.delegate = self
        self.zipcodeLabel.delegate = self
        self.phoneNumberLabel.delegate = self
        homeTypeOutlet.dataSource = self
        homeTypeOutlet.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton)
    {
        let backToHome = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
            self.present(backToHome, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is uploadPhotosViewController
        {
            let vc = segue.destination as? uploadPhotosViewController
            vc?.key = key
        }
    }
    
    @IBAction func continueToPhotosBtn(_ sender: UIButton) {
            addCustomerInfo()
            performSegue(withIdentifier: "PresentPhotosPage", sender: self)
    }
    ///////////////////////////////////////////////////////////////////////////////////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
   ////////////////////////////////////////////////////////////////////////////////////////////

    func addCustomerInfo()
    {
        key = (firebaseReference?.childByAutoId().key)!
        
        if(nameLabel.text != nil && addressLabel.text != nil && cityLabel.text != nil && stateLabel.text != nil && zipcodeLabel.text != nil && phoneNumberLabel.text != nil && homeTypeFromPicker.text != nil)
        {
            let customer = ["ID": key,
                        "Name": nameLabel.text!,
                        "Address": addressLabel.text!,
                        "City": cityLabel.text!,
                        "State": stateLabel.text!,
                        "Zipcode":zipcodeLabel.text!,
                        "PhoneNumber": phoneNumberLabel.text!,
                        "Hometype": homeTypeFromPicker.text!]
            firebaseReference!.child(key).setValue(customer)
        }
        else{
            let alert = UIAlertController(title: "Whoops!", message: "You are missing fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title:"Okay", style: .default, handler:  { action in self.performSegue(withIdentifier: "HomeUploadViewController", sender: self)}))
            self.present(alert,animated: true, completion: nil)
        }
        
    }
    ///////////////////////////////////////////////////////////////////////////////////////////
}



extension uploadHomeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return homeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        homeTypeFromPicker.text = homeTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return homeTypes[row]
    }
    
}
