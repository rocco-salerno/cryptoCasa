//
//  customerInformationModel.swift
//  Login_Register
//
//  Created by Rocco Salerno on 9/29/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit

struct CustomerInformation{
    var customerName: String
    var customerAddress: String
    var customerZipcode: String
    var customerPhone: String
    var customerCity: String
    var customerState: String
    var customerHomeType: String
}


class CustomerInformationModel{

    var customerInformation = CustomerInformation(customerName: "", customerAddress: "", customerZipcode: "", customerPhone: "", customerCity: "", customerState: "", customerHomeType: "")
}
