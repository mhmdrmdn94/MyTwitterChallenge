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

class LoginViewController: BaseViewController {

   
    let usersDropDown = DropDown()
    var usersDropDown_dataSource : [String] = []
    static var selectedUser : (username: String, userid: String) = ("","")
    
    
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
    
        let followersVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as! FollwersTableViewController
        
        followersVC.loggedUserData = LoginViewController.selectedUser
   
        self.navigationController?.pushViewController(followersVC, animated: true)
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
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        if usersDropDown_dataSource.isEmpty{
            dropDownBtn.titleLabel?.textColor = UIColor.red
        }else{
            dropDownBtn.titleLabel?.textColor = UIColor.blue
        }
        
        
        
        usersDropDown_dataSource = []
        LoginViewController.selectedUser = ("", "")
        loginBtn.isEnabled = false
        
        usersDropDown.anchorView = dropDownBtn
        
        //// get last loggedin users from NSUserDefaults
        if UserDefaults.standard.value(forKey: ConstantUrls.loggedinsKey) != nil
        {
            /// append loggedIns to the dropDown menu
            let usersDict = UserDefaults.standard.value(forKey: ConstantUrls.loggedinsKey) as! [String:String]
                
            
            for user in usersDict
            {
                usersDropDown_dataSource.append(user.key)
            }
            
            if !usersDropDown_dataSource.isEmpty
            {
                LoginViewController.selectedUser = ("", "")
                loginBtn.isEnabled = false
                dropDownBtn.setTitle("Tap to select", for: .normal)
                dropDownBtn.titleLabel?.textColor = UIColor.blue
          
            }else{
                //// All are loggedOUT
                /// No recent logs
                dropDownBtn.setTitle("No Recent Logs!", for: .normal)
                dropDownBtn.titleLabel?.textColor = UIColor.red
                LoginViewController.selectedUser = ("", "")
                loginBtn.isEnabled = false
                
            }
            
        }else{
            //// No recent logs
            dropDownBtn.setTitle("No Recent Logs!", for: .normal)
            dropDownBtn.titleLabel?.textColor = UIColor.red
            LoginViewController.selectedUser = ("", "")
            loginBtn.isEnabled = false
            
        }
        
        
        usersDropDown.dataSource = usersDropDown_dataSource
      
        // Action triggered on menu item selection
        usersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            LoginViewController.selectedUser.username = item
        
            /// get selected userid
            let usersDict = UserDefaults.standard.value(forKey: ConstantUrls.loggedinsKey) as! [String:String]
            LoginViewController.selectedUser.userid = usersDict[item]!
            
            self.loginBtn.isEnabled = true
            self.dropDownBtn.setTitle(item, for: .normal)
            print("Selected item: \(LoginViewController.selectedUser) ")
            
        }

        
    }///End of ViewWillAppear
    
    
    
    //MARK:- Dynamically add TWTRLoginBtn
    func addTWTRLoginBtn(){
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                // New User >>> Coming from safari
         
                let followersVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as! FollwersTableViewController

                followersVC.loggedUserData = ( session?.userName, session?.userID ) as? (username: String, userid: String)
                
                self.navigationController?.pushViewController(followersVC, animated: true)
                
            }else{
               
                // show an ALERT includes ErrorDesc.
                print("error: \(String(describing: error?.localizedDescription))");
                self.showErrorMsg(errorMsg: (error?.localizedDescription)!)
            }
        })
        
        logInButton.center = self.lowerVeiw.center
        self.view.addSubview(logInButton)
    }
    
    
    //MARK:- This is where I populate LoggedInsUsers dictionary to UserDefaults from TWTRSessionStore
    static func updateUserDefaultsLoggedInUsers(){
        
        var loggedDictionary : [String:String] = [:]
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        for session in sessions{
            
            let sessionObj = session as! TWTRSession
            loggedDictionary[sessionObj.userName] = sessionObj.userID
        }
        
        UserDefaults.standard.set(loggedDictionary, forKey: ConstantUrls.loggedinsKey)
    }
    
}



//MARK:- Extension for LoginVeiwProtocol
extension LoginViewController : LoginViewProtocol{

    func showProgressBar(){
    
    
    }
    
    func hideProgressBar(){
    
    
    }
    
    func showErrorMsg(errorMsg : String){
    
    
    }
    
    
}
