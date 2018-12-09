//
//  uploadHomeViewController.swift
//  Login_Register
//
//  Created by Gibriel Spiteri on 9/18/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import FirebaseDatabase
import LocalAuthentication
import FirebaseAuth

class uploadHomeViewController: UIViewController, UITextFieldDelegate {
    var theListing:String = ""
    let userIDKey = Auth.auth().currentUser!.uid
    var firebaseReference:DatabaseReference?
    var firebaseReference2:DatabaseReference?
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var listingNameLabel: UITextField!
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
    var listingname: String = ""
    var uniqueIDKeyString: String = ""
    
    
    @IBOutlet weak var homeTypeOutlet: UIPickerView!
    @IBOutlet weak var homeTypeFromPicker: UITextField!
    
    private let homeTypes = ["Ranch", "Split Level", "Victorian","Condo", "Duplex", "Penthouse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorThings()
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        
        firebaseReference = Database.database().reference().child("Users").child(userIDKey)
        firebaseReference2 = Database.database().reference().child("Listings").childByAutoId()
        
        
        self.nameLabel.delegate = self
        self.addressLabel.delegate = self
        self.cityLabel.delegate = self
        self.stateLabel.delegate = self
        self.zipcodeLabel.delegate = self
        self.phoneNumberLabel.delegate = self
        self.listingNameLabel.delegate = self
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
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        let backToHome = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(backToHome, animated: true)
    }
    
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var uniqueIDKey = firebaseReference2?.key
        
        if segue.destination is uploadPhotosViewController
        {
            name = nameLabel.text!
            phonenumber = phoneNumberLabel.text!
            address = addressLabel.text!
            city = cityLabel.text!
            state = stateLabel.text!
            hometype = homeTypeFromPicker.text!
            zipcode = zipcodeLabel.text!
            listingname = listingNameLabel.text!
            uniqueIDKeyString = uniqueIDKey!
            
            let vc = segue.destination as? uploadPhotosViewController
            vc?.theListing = theListing
            vc?.name = name
            vc?.phonenumber = phonenumber
            vc?.address = address
            vc?.city = city
            vc?.state = state
            vc?.hometype = hometype
            vc?.zipcode = zipcode
            vc?.listingname = listingname
            vc?.uniqueIDKeyString = uniqueIDKeyString
        }
    }
    
    @IBAction func continueToPhotosBtn(_ sender: UIButton) {
        if(nameLabel.text != nil && addressLabel.text != nil && cityLabel.text != nil && stateLabel.text != nil && zipcodeLabel.text != nil && phoneNumberLabel.text != nil && listingNameLabel.text != nil && homeTypeFromPicker.text != nil)
        {
           // addCustomerInfo()
            performSegue(withIdentifier: "PresentPhotosPage", sender: self)
        }
        else{
            let alert = UIAlertController(title: "Whoops!", message: "You are missing fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title:"Okay", style: .default, handler:  { action in self.performSegue(withIdentifier: "HomeUploadViewController", sender: self)}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
   ////////////////////////////////////////////////////////////////////////////////////////////

    func addCustomerInfo()
    {
        
        if(nameLabel.text != nil && addressLabel.text != nil && cityLabel.text != nil && stateLabel.text != nil && zipcodeLabel.text != nil && phoneNumberLabel.text != nil && listingNameLabel.text != nil && homeTypeFromPicker.text != nil)
        {
            let listing = [
                        "Name": nameLabel.text!,
                        "Address": addressLabel.text!,
                        "City": cityLabel.text!,
                        "State": stateLabel.text!,
                        "Zipcode":zipcodeLabel.text!,
                        "PhoneNumber": phoneNumberLabel.text!,
                        "ListingName": listingNameLabel.text!,
                        "Hometype": homeTypeFromPicker.text!]
            firebaseReference!.child(firebaseReference2!.key!).setValue(listing)
            firebaseReference2!.setValue(listing)
        }
        else{
            let alert = UIAlertController(title: "Whoops!", message: "You are missing fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title:"Okay", style: .default, handler:  { action in self.performSegue(withIdentifier: "HomeUploadViewController", sender: self)}))
            self.present(alert,animated: true, completion: nil)
        }
        
    }
    
/////////////////////////////////////////////////////////////////////////////////////////////////////
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
    
    
    func colorThings()
    {
        nameLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.cornerRadius = 15
        
        addressLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addressLabel.layer.borderWidth = 1
        addressLabel.layer.cornerRadius = 15
        
        cityLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cityLabel.layer.borderWidth = 1
        cityLabel.layer.cornerRadius = 15
        
        stateLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        stateLabel.layer.borderWidth = 1
        stateLabel.layer.cornerRadius = 15
        
        zipcodeLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        zipcodeLabel.layer.borderWidth = 1
        zipcodeLabel.layer.cornerRadius = 15
        
        phoneNumberLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        phoneNumberLabel.layer.borderWidth = 1
        phoneNumberLabel.layer.cornerRadius = 15
        
        listingNameLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        listingNameLabel.layer.borderWidth = 1
        listingNameLabel.layer.cornerRadius = 15
    }
}
