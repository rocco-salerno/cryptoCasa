//
//  MenuTableViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 11/17/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //deleting all unused rows
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func HomeBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.present(vc!, animated: false, completion: nil)
        
    }
    
}
