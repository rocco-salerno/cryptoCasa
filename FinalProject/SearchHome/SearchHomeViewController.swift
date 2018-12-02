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
import Alamofire

class SearchHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var ref:  DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var ListArr = [ListModel]()
    var listingArray = [String]()
    var myIndex = 0
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ref = Database.database().reference().child("Listings")
        tableView.delegate = self
        tableView.dataSource = self
        //deleting all unused rows
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        //getting a snapshot of all children and their values
        let ref = Database.database().reference().child("Listings")
        ref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
                return
            }
            let Obj = ListModel()
            Obj.ListingID = snapshot.key
            Obj.PhotoURL = (dictionary["PhotoURL"] as? String)!
            Obj.ListingName = (dictionary["ListingName"] as? String)!
            Obj.Address = (dictionary["Address"] as? String)!
            Obj.City = (dictionary["City"] as? String)!
            //Obj.HomeType = (dictionary["HomeType"] as? String)!
            Obj.Name = (dictionary["Name"] as? String)!
            Obj.PhoneNumber = (dictionary["PhoneNumber"] as? String)!
            Obj.Price = (dictionary["Price"] as? String)!
            Obj.State = (dictionary["State"] as? String)!
            Obj.WalletID = (dictionary["WalletID"] as? String)!
            Obj.Zipcode = (dictionary["Zipcode"] as? String)!
            
            
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
                    self.tableView.reloadData()
                }
            }})
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell") as! SearchHomeTableViewCell
        cell.listingImage.clipsToBounds = true;
        let listing = ListArr[indexPath.row]
        cell.listingImage.contentMode = .scaleToFill
       let downloadURL = URL(string: listing.PhotoURL)
     /*   URLSession.shared.dataTask(with: downloadURL!, completionHandler: {(data, response, error) in
            if let error = error {
                print("Image read error \(error)")
                return
            }
            cell.listingImage.image = UIImage(data: data!)
        }).resume()
        */
       Alamofire.request(downloadURL!).responseData { (response) in
                if response.error == nil {
                    print(response.result)
                
                    // Show the downloaded image:
                    if let data = response.data {
                        cell.listingImage.image = UIImage(data: data)
                        }
                    }
        }
        
        cell.listingNameLabel.text = ListArr[indexPath.row].ListingName
        cell.addressLabel.text = ListArr[indexPath.row].Address
        cell.stateLabel.text = ListArr[indexPath.row].State
        cell.cityLabel.text = ListArr[indexPath.row].City
        cell.zipcodeLabel.text = ListArr[indexPath.row].Zipcode
        cell.phoneLabel.text = ListArr[indexPath.row].PhoneNumber
        cell.priceLabel.text = ListArr[indexPath.row].Price
        //cell.walletidLabel.text = ListArr[indexPath.row].WalletID
        //cell.nameLabel.text = ListArr[indexPath.row].Name
        cell.hometypeLabel.text = ListArr[indexPath.row].HomeType
       // cell.homeDetailsLabel.text = ListArr[indexPath.row].HomeDetails
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
    
        if segue.destination is SelectedHomeViewController
        {
            let vc = segue.destination as? SelectedHomeViewController
            vc?.ListArr = ListArr
            vc?.myIndex = myIndex
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "toSelectedHome", sender: self)
    }

}
