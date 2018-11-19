//
//  HomeDetailsViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 9/30/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var theListing:String = ""
    var name: String = ""
    var address: String = ""
    var phonenumber: String = ""
    var city: String = ""
    var state: String = ""
    var zipcode: String = ""
    var hometype: String = ""
    var listingname: String = ""
    var uniqueIDKeyString: String = ""
    var firebaseReference: DatabaseReference?
    var firebaseReference2: DatabaseReference?
    
    let userIDKey = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var homeDescription: UITextView!
    @IBOutlet weak var walletIDTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseReference = Database.database().reference().child("Homes").child(userIDKey)
        firebaseReference2 = Database.database().reference().child("Listings").child(uniqueIDKeyString)
        
        self.priceTxtField.delegate = self
        self.walletIDTxtField.delegate = self
        
    }
    
    @IBAction func BackToPhotoUploadBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPhotoUpload", sender: self)
    }
    
    @IBAction func finishListingBtn(_ sender: UIButton) {
        uploadExtraInfo()
        
        let alert = UIAlertController(title: "Success!", message: "Your Listing Was Created!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Proceed", style: .default, handler:  { action in self.performSegue(withIdentifier: "BackHomePage", sender: self)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    //function to upload to firebase
    func uploadExtraInfo()
    {
        if(priceTxtField != nil && homeDescription != nil && walletIDTxtField != nil)
        {
            let info = [
                        "Price": priceTxtField.text!,
                        "HomeDetails": homeDescription.text!,
                        "WalletID": walletIDTxtField.text!,
                        "Name": name,
                        "Address": address,
                        "City": city,
                        "State": state,
                        "Zipcode":zipcode,
                        "PhoneNumber": phonenumber,
                        "ListingName": listingname,
                        "Hometype": hometype] as [String : Any]
            firebaseReference!.child(theListing).setValue(info)
            firebaseReference2?.child(theListing).setValue(info)
        }
    }
    
    //keyboard disappears on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}//HomeDetailViewController
