
import UIKit
import MessageUI

class CreateClaimViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var submitOutlet: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var claimTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTxt.delegate = self
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        
        view.addGestureRecognizer(Tap)
        
        borders()
        sideMenu()
        
    }
    @objc func DismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        sendEnmail()
    }
    
    
    
    
    
    
    func sideMenu()
    {
        if revealViewController != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 275
            revealViewController()?.rightViewRevealWidth = 160
            
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)                                          ///// to return keyboard
        return false
    }
    
    func borders()
    {
        nameTxt.layer.borderWidth = 1
        nameTxt.layer.borderColor = UIColor.white.cgColor
        nameTxt.layer.cornerRadius = 15
        
        claimTxt.layer.borderWidth = 1
        claimTxt.layer.borderColor = UIColor.white.cgColor
        claimTxt.layer.cornerRadius = 15
        
        submitOutlet.layer.borderWidth = 1
        submitOutlet.layer.borderColor = UIColor.white.cgColor
        submitOutlet.layer.cornerRadius = 15
    }
    
    func sendEnmail()
    {
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Claim")
            mail.setToRecipients(["cryptoCasaClaims@gmail.com"])
            mail.setMessageBody("<h4>\(nameTxt.text!),If you wish to add photos, please do so now. </h4><p>\(claimTxt.text!)</p>", isHTML: true)
            
            present(mail, animated: true)
        }
        else
        {
            print("error with mail")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
