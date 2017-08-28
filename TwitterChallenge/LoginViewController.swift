//
//  ViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/23/17.
//
//

import UIKit
import TwitterKit
import DropDown

class LoginViewController: UIViewController {

    
    
    static var fromSafari = false
    let usersDropDown = DropDown()
    var usersDropDown_dataSource : [String] = []
   
    var currentSelectedUsername : String = "" {
        didSet{
            
            if !currentSelectedUsername.isEmpty{
            
                loginBtn.isEnabled = true
                print("CurrentSelectedUsername = \( currentSelectedUsername )")
            }else{
                
                print("CurrentSelectedUsername = \( currentSelectedUsername )")
                loginBtn.isEnabled = false
            }
        }
    }
    
    
    
    
    //MARK:- Outlets and Actions
    
    
    @IBOutlet weak var lowerVeiw: UIView!
    
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBAction func dropDownBtnTapped(_ sender: UIButton) {
        
        
            if !usersDropDown_dataSource.isEmpty {
                
                usersDropDown.show()
            }
        
    }
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func loginBtnTapped(_ sender: UIButton) {
    
        print("Logging in .... :)")
    
    }
    
    
    
    //MARK:- ViewDidLoad and ViewDidAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Home Screen is Loaded ...")
     
        ///// Dynamically add the LoginWithTwitter button for one time
        self.addTWTRLoginBtn()
        
      
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if LoginViewController.fromSafari{
        
            print("Direct to FollowersList")
        
            LoginViewController.fromSafari = false
            
        }
        
        
        
        
        
        /////// - - - - -
        
        usersDropDown_dataSource = []
        currentSelectedUsername = ""
        
        usersDropDown.anchorView = dropDownBtn
        
        
        //// get last loggedin users from NSUserDefaults
        if UserDefaults.standard.value(forKey: ConstantUrls.loggedinsKey) != nil
        {
            /// append loggedIns to the dropDown menu
            let usersDict = UserDefaults.standard.value(forKey: ConstantUrls.loggedinsKey) as! [String:String]
                
            
            for user in usersDict
            {
                    usersDropDown_dataSource.append(user.value)
            }
            
            if !usersDropDown_dataSource.isEmpty
            {
                    currentSelectedUsername = ""
                    dropDownBtn.setTitle("Tap to select", for: .normal)
                    dropDownBtn.titleLabel?.textColor = UIColor.blue
          
            }else{
                    //// All are loggedOUT
                    /// No recent logs
                    dropDownBtn.setTitle("No Recent Logs!", for: .normal)
                    dropDownBtn.titleLabel?.textColor = UIColor.red
                    currentSelectedUsername = ""
          
            }
            
        }else{
            //// No recent logs
            dropDownBtn.setTitle("No Recent Logs!", for: .normal)
            dropDownBtn.titleLabel?.textColor = UIColor.red
            currentSelectedUsername = ""
        }
        
     
        
        
        usersDropDown.dataSource = usersDropDown_dataSource
        
        
        // Action triggered on menu item selection
        usersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.currentSelectedUsername = item
            self.dropDownBtn.setTitle(item, for: .normal)
            print("Selected item: \(item) ")
            
        }

        
        
        
    }
    
    
    func addTWTRLoginBtn(){
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                
                print("signed in as \(String(describing: session?.userName))");
                
                
            } else {
                
                print("error: \(String(describing: error?.localizedDescription))");
                
            }
        })
        
        logInButton.center = self.lowerVeiw.center
        
        self.view.addSubview(logInButton)
    }
    
    

}

