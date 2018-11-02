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
    var key:String = ""
    
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
    
    //send key value to HomeDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomeDetailsViewController
        {
            let vc = segue.destination as? HomeDetailsViewController
            vc?.key = key
        }
    }
    
    //upload image to firebase function
    func uploadImageToFirebase(data: NSData)
    {
        //reference to location where photos will be stored
        let storageReference = Storage.storage().reference(withPath: "Customer_Photos/\(key).jpg")
        //upload files to firebase
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        storageReference.putData(data as Data, metadata: uploadMetadata)
    }

}//end uploadPhotoViewController


extension uploadPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }//ImagePickerCancel function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let imageData = UIImageJPEGRepresentation(image!, 0.8)
        uploadImageToFirebase(data: imageData as! NSData)
        
        self.dismiss(animated: true, completion: nil)
        
        
    }//imagePickerController
}
