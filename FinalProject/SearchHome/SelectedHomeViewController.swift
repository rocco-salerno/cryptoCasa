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
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthOutlet: UILabel!
    @IBOutlet weak var yearOutlet: UILabel!
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
    @IBOutlet weak var totalAmount: UILabel!
    
    
    var rangeSelectedDates = [Date]()
    var nightsStayed = 0
    
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
        calendarView.allowsMultipleSelection = true
        calendarView.isRangeSelectionUsed = true
        
        getImage()
        setupCalendar()
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState)
    {
        guard let validCell = view as? CustomCell else {return}
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else{
            if cellState.dateBelongsTo == .thisMonth
            {
                validCell.dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            else{
                validCell.dateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
    }
    
    func updateTotal()
    {
        if nightsStayed == 0
        {
            totalAmount.text = String(0)
        }
        else if nightsStayed == 1
        {
            totalAmount.text = priceLabel.text
        }
        else
        {
            self.totalAmount.text = String(Int(priceLabel.text!)! * nightsStayed)
        }
    }
    
    //handles the cells that are selected
    func handleCellSelected(view: JTAppleCell?, cellState: CellState)
    {
     guard let validCell = view as? CustomCell else {return}
        if cellState.isSelected
        {
            validCell.selectedView.isHidden = false
        }else{
            validCell.selectedView.isHidden = true
        }
    }
    
    func setupCalendar()
    {
        //getting rid of the border between the cells
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //Setup the labels when app is loaded
        calendarView.visibleDates{ visibleDates in
            let date = visibleDates.monthDates.first!.date
            
            self.formatter.dateFormat = "yyyy"
            self.yearOutlet.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.monthOutlet.text = self.formatter.string(from: date)
        }
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
        
        handleCellSelected(view: myCustomCell, cellState: cellState)
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from:"2018 12 01")!
        let endDate = formatter.date(from: "2020 12 30")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func sharedFunctionToConfigureCell(myCustomCell: CustomCell, cellState: CellState, date: Date)
    {
        myCustomCell.dateLabel.text = cellState.text
        
    }
    
    //when the user selects a date
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        rangeSelectedDates.append(date)
        nightsStayed = rangeSelectedDates.count - 1
        updateTotal()
        print(rangeSelectedDates.count)
        print(nightsStayed)
    }
    
    //when the user deselects a date
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        rangeSelectedDates.remove(at: rangeSelectedDates.count - 1)
        if(nightsStayed > 0)
        {
            nightsStayed = rangeSelectedDates.count - 1
        }
        else
        {
            nightsStayed = 0
        }
        updateTotal()
        
        print(rangeSelectedDates.count)
        print(nightsStayed)
    }
    
    //changes month and year when user scrolls
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        yearOutlet.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        monthOutlet.text = formatter.string(from: date)
    }
}
