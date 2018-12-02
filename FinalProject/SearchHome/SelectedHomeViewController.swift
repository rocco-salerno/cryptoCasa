//
//  SelectedHomeViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 12/2/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class SelectedHomeViewController: UIViewController {

    @IBOutlet weak var listingNameLabel: UILabel!
    var ListArr = [ListModel]()
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listingNameLabel.text = ListArr[myIndex].ListingName
    }
    
}
