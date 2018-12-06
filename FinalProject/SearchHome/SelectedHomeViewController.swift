//
//  SelectedHomeViewController.swift
//  Login_Register
//
//  Created by Rocco Salerno on 12/2/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Alamofire

class SelectedHomeViewController: UIViewController {

    let formatter = DateFormatter()
    
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var listingImage: UIImageView!
    @IBOutlet weak var listingNameLabel: UILabel!
    @IBOutlet weak var homeTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var ListArr = [ListModel]()
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listingNameLabel.text = ListArr[myIndex].ListingName
        homeTypeLabel.text = ListArr[myIndex].HomeType
        nameLabel.text = ListArr[myIndex].Name
        cityLabel.text = ListArr[myIndex].City
        stateLabel.text = ListArr[myIndex].State
        zipcodeLabel.text = ListArr[myIndex].Zipcode
        addressLabel.text = ListArr[myIndex].Address
        detailsLabel.text = ListArr[myIndex].HomeDetails
        priceLabel.text = ListArr[myIndex].Price
        phoneNumberLabel.text = ListArr[myIndex].PhoneNumber
        getImage()
    }
    
    func getImage()
    {
        let downloadURL = URL(string: ListArr[myIndex].PhotoURL)
       
        Alamofire.request(downloadURL!).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data {
                    self.listingImage.image = UIImage(data: data)
                }
            }
        }
    }//getImage
    
}

extension SelectedHomeViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
 
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        sharedFunctionToConfigureCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from:"2018 01 01")!
        let endDate = formatter.date(from: "2020 12 30")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date)
    {
        myCustomCell.dateLabel.text = cellState.text
        
    }
}
