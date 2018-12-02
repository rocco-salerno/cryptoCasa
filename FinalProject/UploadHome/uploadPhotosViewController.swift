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

class uploadPhotosViewController: UIViewController {
    
    
    var firebaseReference:DatabaseReference?
    
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
    var imageID: String = ""
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        firebaseReference = Database.database().reference()
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
    
    //move to the Home Details View page
    @IBAction func toHomeDetails(_ sender: UIButton) {
      performSegue(withIdentifier: "PresentDetailsPage", sender: self)
    }
    
    //send values to HomeDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomeDetailsViewController
        {
            let vc = segue.destination as? HomeDetailsViewController
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
            vc?.imageURLString = imageURLString
        }
    }
    
    //upload image to firebase function
    func uploadImageToFirebase(data: NSData)
    {
        var imageURL: String = ""
        //reference to location where photos will be stored
        var theImageID = NSUUID().uuidString + ".jpg"
        imageID = theImageID
        let storageReference = Storage.storage().reference(withPath: "Listings/\(imageID)")
        
        //upload files to firebase
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        storageReference.putData(data as Data, metadata: uploadMetadata) {(metadata, error) in
            if(error != nil){print(error)}
            else{
                storageReference.downloadURL(completion: {(url, error) in
                    if(error != nil){
                        print(error)
                        return
                    }
                    if(url != nil){
                        imageURL = url!.absoluteString
                        print("IT ACTUALLY WORKS:\(imageURL)")
                        self.imageURLString = imageURL
                    }
                })
            }
        }
       // imageURLString = imageURL
    }

}//end uploadPhotoViewController


extension uploadPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }//ImagePickerCancel function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        var imageDownloadURL: String = ""
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let imageData = UIImageJPEGRepresentation(image!, 0.8)
        uploadImageToFirebase(data: imageData as! NSData)
        self.dismiss(animated: true, completion: nil)
        
        
    }//imagePickerController
}
