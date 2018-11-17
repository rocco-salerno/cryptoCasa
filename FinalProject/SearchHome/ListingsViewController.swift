//
//  ListingsViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 11/17/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var ref:  DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var myListings = ["Message1", "Message2"]
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
            
       databaseHandle = ref?.child("Homes").observe(.childAdded, with: { (snapshot) in
            
            //when a child is added under Homes
            //take the value snapshot and add it to the myListingsArray
            let post = snapshot.value as? String
        
        if let actualPost = post{
            self.myListings.append(actualPost)
            
            
        }
        })
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell")
        cell?.textLabel?.text = myListings[indexPath.row]
        
        return cell!
    }
    
    
    
}
