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
import FirebaseAuth

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
    var imageURLString: String = ""
    var privateKey: String = ""
    
    
    var firebaseReference: DatabaseReference?
    var firebaseReference2: DatabaseReference?
    
    let userIDKey = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var homeDescription: UITextView!
    @IBOutlet weak var walletIDTxtField: UITextField!
    @IBOutlet weak var privateKeyTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        
        firebaseReference = Database.database().reference().child("Users").child(userIDKey)
        firebaseReference2 = Database.database().reference().child("Listings")
        
        self.priceTxtField.delegate = self
        self.walletIDTxtField.delegate = self
        
    }
    
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func BackToPhotoUploadBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToPhotoUpload", sender: self)
    }
    
    func sendListingIDToSmartContract()
    {
        privateKey = privateKeyTxt.text!
        let theListingID = firebaseReference!.child(userIDKey).child(uniqueIDKeyString).key
        print(theListingID!)
        // prepare json data
        let json: NSDictionary = ["ListingID": theListingID!, "PrivateKey": privateKey]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print("This is json data: ",String(decoding: jsonData!, as: UTF8.self))
        
        // create post request
        let url = URL(string: "http://cryptocasa.us-east-2.elasticbeanstalk.com/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("This is the JSON Respons: ",responseJSON)
            }
        }
        
        task.resume()
    }//end Post request
    
    @IBAction func finishListingBtn(_ sender: UIButton) {
        uploadExtraInfo()
        sendListingIDToSmartContract()
        
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
                        "PhotoURL": imageURLString,
                        "Hometype": hometype] as [String : Any]
            firebaseReference!.child(uniqueIDKeyString).setValue(info)
            firebaseReference2?.child(uniqueIDKeyString).setValue(info)
        }
    }
    
    //keyboard disappears on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}//HomeDetailViewController
