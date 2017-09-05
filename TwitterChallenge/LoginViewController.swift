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
import MBProgressHUD


class LoginViewController: BaseViewController {

   
    let usersDropDown = DropDown()
    var usersDropDown_dataSource : [String] = []
    static var selectedUser = User(username: "", userid: "", prevCursor: "0", nextCursor: "-1")
    var progressBar : MBProgressHUD?
    var presenter : LoginPresenter?
    
    
    //MARK:- Outlets and Actions
    
    
    @IBOutlet weak var lowerVeiw: UIView!
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBAction func dropDownBtnTapped(_ sender: UIButton) {
        
            if !usersDropDown_dataSource.isEmpty {
                
                usersDropDown.show()
            }
    }
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func loginBtnTapped(_ sender: UIButton) {
    
        print("Logging in .... :)")
        print("getting bearerToken ..")
        
        self.getBearerToken()
        
    }
    
    //MARK:- Clearing login history
    @IBAction func clearHistoryTapped(_ sender: UIButton) {
   
        
        let alert = UIAlertController(title: "Warning!", message: "Do you really want to clear login history?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Clear History", style: .destructive) { action in
            
            self.clearHistory()
            
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { action in
            // perhaps use action.title here
            
            //Do nothing
            
        })
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func clearHistory() {
        
        
        print("Clearing Login History ...")
        
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        for session in sessions{
            
            let sessionObj = session as! TWTRSession
            store.logOutUserID(sessionObj.userID)
            
        }
        
        UserDefaults.standard.removeObject(forKey: ConstantUrls.loggedinUsersKey)
        //LoginViewController.updateUserDefaultsLoggedInUsers()
        
        usersDropDown_dataSource = []
        dropDownBtn.setTitleColor(UIColor.red, for: .normal)
        dropDownBtn.setTitle("No Recent Logs!", for: .normal)
        LoginViewController.selectedUser = User(username: "", userid: "", prevCursor: "0", nextCursor: "-1")
        loginBtn.isEnabled = false
        
        
        
        
    }
    
    
    
    //MARK:- ViewDidLoad and ViewDidAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Home Screen is Loaded ...")
     
        ///// Dynamically add the LoginWithTwitter button for one time
        self.addTWTRLoginBtn()
        
        
        
        //Linking presenter
        self.presenter = LoginPresenter(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //Check first if a user is already logged-in
        
        if let savedobj = UserDefaults.standard.object(forKey: ConstantUrls.currentLoggedInUserKey) as? Data {
           
            let currentUserObj = NSKeyedUnarchiver.unarchiveObject(with: savedobj) as! User
    
            LoginViewController.selectedUser = currentUserObj
      
            self.getBearerToken()
  
        }
        
       
        
        self.navigationController?.isNavigationBarHidden = true
        
        usersDropDown_dataSource = []
        //LoginViewController.selectedUser = User(username: "", userid: "", prevCursor: "", nextCursor: "")
        loginBtn.isEnabled = false
        
        usersDropDown.anchorView = dropDownBtn
        
        //// get last loggedin users from NSUserDefaults
        if let usersData = UserDefaults.standard.object(forKey: ConstantUrls.loggedinUsersKey) as? Data {
            
            let usersDict = NSKeyedUnarchiver.unarchiveObject(with: usersData) as! [String:User]
            
            
            for user in usersDict
            {
                usersDropDown_dataSource.append(user.key)
            }
            
            if !usersDropDown_dataSource.isEmpty
            {
                //LoginViewController.selectedUser = User(username: "", userid: "", prevCursor: "", nextCursor: "")
                loginBtn.isEnabled = false
                dropDownBtn.setTitle("Tap to select", for: .normal)
                
            }else{
                //// All are loggedOUT
                /// No recent logs
                dropDownBtn.setTitle("No Recent Logs!", for: .normal)
                //LoginViewController.selectedUser = User(username: "", userid: "", prevCursor: "", nextCursor: "")
                loginBtn.isEnabled = false
                
            }
        
        }else{
            //// No recent logs
            dropDownBtn.setTitle("No Recent Logs!", for: .normal)
            //LoginViewController.selectedUser = User(username: "", userid: "", prevCursor: "", nextCursor: "")
            loginBtn.isEnabled = false
            
        }
        
        
        usersDropDown.dataSource = usersDropDown_dataSource
      
        if usersDropDown_dataSource.isEmpty{
            dropDownBtn.setTitleColor(UIColor.red, for: .normal)
        }else{
            dropDownBtn.setTitleColor(UIColor.blue, for: .normal)
        }

        
        // Action triggered on menu item selection
        usersDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            LoginViewController.selectedUser.username = item
        
            /// get selected userid
            
            if let usersData = UserDefaults.standard.object(forKey: ConstantUrls.loggedinUsersKey) as? Data {
                
                let usersDict = NSKeyedUnarchiver.unarchiveObject(with: usersData) as! [String:User]
            
                LoginViewController.selectedUser = usersDict[item]!
                
                print("### onSelected:: \(LoginViewController.selectedUser.userid), nxt=\(LoginViewController.selectedUser.nextCursor), pre=\(LoginViewController.selectedUser.prevCursor)")
                
                self.loginBtn.isEnabled = true
                self.dropDownBtn.setTitle(item, for: .normal)
            
            }else{
                print("****** ERROR! :: NO LoggedINsDictionary in UserDefaults")
            }
            
        }

        
    }///End of ViewWillAppear
    
    
    
    //MARK:- Dynamically add TWTRLoginBtn
    func addTWTRLoginBtn(){
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                
                // New User >>> Coming from safari
                
                LoginViewController.selectedUser = User(username: (session?.userName)!, userid: (session?.userID)!, prevCursor: "0", nextCursor: "-1")

                print("### onSignUP:: \(LoginViewController.selectedUser.userid)")
                
                LoginViewController.updateUserDefaultsLoggedInUsers()
                
                self.getBearerToken()
                
            }else{
               
                // show an ALERT includes ErrorDesc.
                print("error: \(String(describing: error?.localizedDescription))");
                self.showErrorMsg(errorMsg: (error?.localizedDescription)!)
            }
        })
        
        logInButton.center = self.innerView.center
        self.lowerVeiw.addSubview(logInButton)
    }
    
    
    
    
    
    
    //MARK:- This is where I populate LoggedInsUsers dictionary to UserDefaults from TWTRSessionStore
    
    /*
     
     check first if session user is in LoggedUsersDictionary or NOT
     if true, take care of prev & nxt cursors 
     if false, add new user with ZERO cursor values
     
     */
    
    
    static func updateUserDefaultsLoggedInUsers(){
        
        
        let store = Twitter.sharedInstance().sessionStore
        let sessions = store.existingUserSessions()
        
        // get the logged-in users dictionary

        if let usersData = UserDefaults.standard.object(forKey: ConstantUrls.loggedinUsersKey) as? Data {
            
            var usersDict = NSKeyedUnarchiver.unarchiveObject(with: usersData) as! [String:User]
        
            for session in sessions{
                
                let sessionObj = session as! TWTRSession
                if usersDict.index(forKey: sessionObj.userName) != nil{
                // user already in LoggedUsersDictionary
                
                    /// do nothing
                    
                    
                }else{
                // he is a new user and is NOT in LoggedUsersDictionary
                
                    let newUser = User(username: sessionObj.userName, userid: sessionObj.userID, prevCursor: "0", nextCursor: "-1")
                    usersDict[sessionObj.userName] = newUser
                    
                }
            }
            
            /// update the UserDefaults
            let encodedDict = NSKeyedArchiver.archivedData(withRootObject: usersDict)
            UserDefaults.standard.set(encodedDict, forKey: ConstantUrls.loggedinUsersKey)
            
            
        }else{
            // first time to create logged-ins dictionary
        
            var loggedDictionary : [String:User] = [:]
            let sessionObj = sessions[0] as! TWTRSession
            let newUser = User(username: sessionObj.userName, userid: sessionObj.userID, prevCursor: "0", nextCursor: "-1")
            
            loggedDictionary[sessionObj.userName] = newUser
            
            /// update the UserDefaults
            let encodedDict = NSKeyedArchiver.archivedData(withRootObject: loggedDictionary)
            UserDefaults.standard.set(encodedDict, forKey: ConstantUrls.loggedinUsersKey)
            
            
        }
        
        
    }
    
    
    
    //MARK:- Getting bearerToken
    func getBearerToken(){
        print("### beforeGetBearer \(LoginViewController.selectedUser.userid)")
        self.presenter?.getBearerToken(encodedKeys: ConstantUrls.encodedToken)
        
    }
    
    
}



//MARK:- Extension for LoginVeiwProtocol
extension LoginViewController : LoginViewProtocol{

    func showProgressBar(){
        
        print("VC:: Viewing progress bar ...")
        
        //1. Network Indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        //2. ProgressBar
        progressBar = showMBProgressBar(view: self.view, title: "Authenticating ...")
        progressBar?.show(animated: true)
        
    }
    
    func hideProgressBar(){
        
        print("VC:: Hiding progress bar ...")
        
        //1. Network Indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        //2. ProgressBar
        progressBar?.hide(animated: true)
        
    }
    
    func showErrorMsg(errorMsg : String){
        
        showAlert(message: "Error!", title: errorMsg)
        
    }
    
    func updateBearerTokenValue(bearer: String){
    
        print("** Got bearer and going to followersList :)")
        
        //1. save bearer value
        ConstantUrls.bearerToken = bearer
      
        //2. save current logged-in user to NSUSerDefaults
        let dataObj = NSKeyedArchiver.archivedData(withRootObject: LoginViewController.selectedUser)
        
        UserDefaults.standard.set(dataObj, forKey: ConstantUrls.currentLoggedInUserKey)
        
        //3. navigate to followers view controller
        let followersVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as! FollwersTableViewController
        
        followersVC.loggedUserData = LoginViewController.selectedUser
        followersVC.isFromLogin = true
        print("### beforeNavigation:: \(LoginViewController.selectedUser.userid)")
        
        self.navigationController?.pushViewController(followersVC, animated: true)
        
        
    }
    
}
