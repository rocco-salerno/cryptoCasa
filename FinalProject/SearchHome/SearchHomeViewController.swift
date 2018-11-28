//
//  SearchHomeViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 11/18/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SearchHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var ref:  DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var listingsArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        //deleting all unused rows
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        databaseHandle = ref?.child("Listings").observe(.value, with: { (snapshot) in
            
            //try to convert our data to a String
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    var userListings = child.key as! String
                    //append data to myListings array
                    self.listingsArray.append(userListings)
                    
                    //reload the tableview
                    self.tableView.reloadData()
                }
            }})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell")
        cell?.textLabel?.text = listingsArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    


}
