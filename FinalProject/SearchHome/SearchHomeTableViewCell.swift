//
//  SearchHomeTableViewCell.swift
//  Login_Register
//
//  Created by Rocco Salerno on 11/29/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

class SearchHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var listingImage: UIImageView!
    
   
    @IBOutlet weak var listingNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hometypeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
