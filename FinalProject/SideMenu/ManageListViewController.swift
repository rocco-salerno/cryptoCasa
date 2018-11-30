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
import FirebaseAuth

class ManageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref:  DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var myListings = [String]()
    let userIDKey = Auth.auth().currentUser!.uid
    var listingsArray = [ManageListingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu()
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        //getting a snapshot of all children and their values
        let dref = Database.database().reference().child("Users").child(userIDKey)
        dref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
                return
            }
            let Obj = ManageListingModel()
            Obj.ListingID = snapshot.key
            Obj.ListingName = (dictionary["ListingName"] as? String)!
            
            
            self.listingsArray.append(Obj)
        }, withCancel: nil)
        
        //deleting all unused rows
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        databaseHandle = ref?.child("Users").child(userIDKey).observe(.value, with: { (snapshot) in
            
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
        
        return listingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell")
        cell?.textLabel?.text = listingsArray[indexPath.row].ListingName
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let deleteRef = Database.database().reference().child("Users").child(userIDKey).child(listingsArray[indexPath.row].ListingID)
        let deleteRefListings = Database.database().reference().child("Listings").child(listingsArray[indexPath.row].ListingID)
        
        if editingStyle == .delete {
            listingsArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteRef.removeValue()
            deleteRefListings.removeValue()
            self.tableView.reloadData()
        }
    }
    
    
    func sideMenu()
    {
        if revealViewController != nil {
            menuButtonOutlet.target = revealViewController()
            menuButtonOutlet.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            revealViewController()?.rightViewRevealWidth = 160
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
    }
    
}

