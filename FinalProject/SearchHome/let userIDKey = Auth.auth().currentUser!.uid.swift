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
    var myListings = [String]()
    let userIDKey = Auth.auth().currentUser!.uid
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
            
       databaseHandle = ref?.child("Homes").child(userIDKey).observe(.value, with: { (snapshot) in
        
        //try to convert our data to a String
        if let result = snapshot.children.allObjects as? [DataSnapshot] {
            for child in result {
                var userListings = child.key as! String
                //append data to myListings array
                self.myListings.append(userListings)
            
            //reload the tableview
            self.tableView.reloadData()
        }
        }})
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
