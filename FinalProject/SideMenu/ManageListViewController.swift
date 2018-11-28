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

class ManageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref:  DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var myListings = [String]()
    let userIDKey = Auth.auth().currentUser!.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu()
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
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
        
        return myListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell")
        cell?.textLabel?.text = myListings[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let deleteRef = Database.database().reference().child("Users").child(userIDKey).child(myListings[indexPath.row])
        let deleteRefListings = Database.database().reference().child("Listings").child(myListings[indexPath.row])
        
        if editingStyle == .delete {
            myListings.remove(at: indexPath.row)
            
            //tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteRef.removeValue()
            deleteRefListings.removeValue()
            //tableView.endUpdates()
            myListings.removeAll()
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

