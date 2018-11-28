//
//  ImageUploadManager.swift
//  Login_Register
//
//  Created by Rocco Salerno on 9/29/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import FirebaseStorage

struct Constants {
    struct Customers {
        static let imagesFolder: String = "homeImages"
    }
}


class ImageUploadManager: NSObject {
    
    func uploadImage(_ image: UIImage, completionBlock: (_ url: String?, _ errorMessage: String?) -> Void){
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let imagesReference = storageReference.child(Constants.Customers.imagesFolder)
        
    }
}
