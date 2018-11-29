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

class SearchHomeViewController: UIViewController{
    
    @IBOutlet weak var labelOutlet: UILabel!
    @IBAction func button(_ sender: UIButton) {
        numberofElements.text = String(listingArray.count)
    }
    
    @IBOutlet weak var numberofElements: UILabel!
    var ref:  DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var ListArr = [ListModel]()
    var listingArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ref = Database.database().reference().child("Listings")
//        tableView.delegate = self
   //     tableView.dataSource = self
        //deleting all unused rows
      //  tableView.tableFooterView = UIView(frame: CGRect.zero)

        //getting a snapshot of all children and their values
        let ref = Database.database().reference().child("Listings")
        ref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
                return
            }
            
            let Obj = ListModel()
            Obj.UID = snapshot.key
            Obj.PhotoURL = (dictionary["PhotoURL"] as? String)!
            
            self.labelOutlet.text = Obj.UID
            
            self.ListArr.append(Obj)
            
        }, withCancel: nil)
        
        
        //getting number of listings for cell rows
        databaseHandle = Database.database().reference().child("Listings").observe(.value, with: { (snapshot) in
            //try to convert our data to a String
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    var userListings = child.key as! String
                    //append data to listings array
                    self.listingArray.append(userListings)
                    
                    //reload the tableview
                 //   self.tableView.reloadData()
                }
            }})
    }
    
    
 /*   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell")
        cell?.textLabel?.text = listingArray[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    } */
}
