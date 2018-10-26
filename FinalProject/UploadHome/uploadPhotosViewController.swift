//
//  uploadPhotosViewController.swift
//  Login_Register
//
//  Created by Gibriel Spiteri on 9/18/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class uploadPhotosViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var firebaseReference:DatabaseReference?
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var testName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        firebaseReference = Database.database().reference()
        testName?.text = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackToUploadHomeBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToUploadHome", sender: self)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func chooseImage(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toHomeDetails(_ sender: UIButton) {
        
        let toDetailsPage = self.storyboard?.instantiateViewController(withIdentifier: "homeDetailsPage") as! HomeDetailsViewController
        self.present(toDetailsPage, animated: true)
    }
    

}
