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
import Firebase
import FirebaseAuth

class SelectedHomeViewController: UIViewController {

    let formatter = DateFormatter()
    var ref: DatabaseReference?
    var userIDKey = Auth.auth().currentUser!.uid
    var WalletArray = [GetWallet]()
    
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
    var contractID = ""
    var walletID = ""
    
    var listingID: String = ""
    var rangeSelectedDates = [Date]()
    var nightsStayed = 0
    var ListArr = [ListModel]()
    var myIndex = 0
    var privateKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference().child("Wallets")
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
        listingID = ListArr[myIndex].ListingID
        calendarView.allowsMultipleSelection = true
        calendarView.isRangeSelectionUsed = true
        
        getImage()
        setupCalendar()
        getWallet()
    }
    
    
    @IBAction func rentThehomeButton(_ sender: UIButton) {
        if WalletArray.isEmpty == true
        {
            displayAlertMessage(userMessage: "You need to add a Wallet!")
        }
        else{
            let alert = UIAlertController(title: "Submit Funds", message: "Please Enter Your Private Key", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
                self.privateKey = textField.text!
                print("This is the private key from alert: \(self.privateKey)")
                self.sendListingIDToSmartContract()
                
                let alert2 = UIAlertController(title: "Success!", message: "Your Rental Was Successful!", preferredStyle: UIAlertControllerStyle.alert)
                alert2.addAction(UIAlertAction(title:"Proceed", style: .default, handler:  { action in self.performSegue(withIdentifier: "sendingYouBackHome", sender: self)}))
                print("present it")
                self.present(alert2, animated: true, completion: nil)
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }
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
    
    
    func sendListingIDToSmartContract()
    {
        let walletID = WalletArray[0].userWalletID
        print(walletID)
        
        contractID = ListArr[myIndex].ContractID
       
        // prepare json data
        let json: NSDictionary = ["WalletID": walletID, "ContractID": contractID, "Price": totalAmount.text!, "PrivateKey": privateKey]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print("This is json data: ",String(decoding: jsonData!, as: UTF8.self))
        
        // create post request
        let url = URL(string: "http://cryptocasa.us-east-2.elasticbeanstalk.com/payContract")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print("This is the JSON Response: ",responseJSON)
            }
        }
        
        task.resume()
    }//end Post request
    
    func getWallet()
    {
        let ref = Database.database().reference().child("Wallets").child(userIDKey)
        ref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
                return
            }
            let Obj = GetWallet()
            Obj.userWalletID = (dictionary["WalletID"] as? String)!
            
            
            self.WalletArray.append(Obj)
        }, withCancel: nil)
    }
    
    func displayAlertMessage(userMessage: String)->Void
    {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"We Have A Problem", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction!) in DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
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
