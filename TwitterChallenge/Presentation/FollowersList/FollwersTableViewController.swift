//
//  FollwersTableViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import UIKit
import TwitterKit
import  MBProgressHUD
import WHRoundedImageView

class FollwersTableViewController: BaseTableViewController {

    
    var loggedUserData : User?
    var isFromLogin : Bool?
    var presenter : FollowersPresenterProtocol?
    var progressBar : MBProgressHUD?
    
    var followers : [Follower] = []{
    
        didSet{
            self.tableView.reloadData()
            print("FollowersList has been updated ... :)")
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        print("Followers List is loaded ...")
        
        self.navigationItem.title = "Your Followers"
        
        self.presenter = FollowersPresenter(view: self)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        // Configure Refresh Control
       
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        
        
        if let logged = loggedUserData{
            
            print("FollowersVC >>> currentID=\(logged.username)")
            
            self.presenter?.getFollowers(userid: (loggedUserData?.userid)!, isFromLogin: isFromLogin!)
            
            isFromLogin = false
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        
    }
    
    
    
    //MARK:- Handle tableView refresh
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        print("REFRESHING . ...");
        
        if LoginViewController.selectedUser.nextCursor == "0"{
            // you have received your full list of followers
            refreshControl.endRefreshing()
            return
        }
        
        self.presenter?.getFollowers(userid: (loggedUserData?.userid)!, isFromLogin: false)
        refreshControl.endRefreshing()
    
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followerCell", for: indexPath)

        // Configure the cell...

        
        let followerName = cell.viewWithTag(1) as! UILabel
        let followerHandle = cell.viewWithTag(2) as! UILabel
        let followerBio = cell.viewWithTag(3) as! UILabel
        let followerImage = cell.viewWithTag(4) as! WHRoundedImageView
        
        
        followerName.text = followers[indexPath.row].fullName!
        followerHandle.text = "@\(followers[indexPath.row].screenName!)"
        followerBio.text = followers[indexPath.row].description!
        followerImage.sd_setImage(with: URL(string: followers[indexPath.row].profileImage!), placeholderImage: UIImage(named: "profile_default"))
        
        followerBio.layer.masksToBounds = true
        
        return cell
    }
    
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //// first, check if his time line is protected or not
        if followers[indexPath.row].protected!{
          
            //Sorry, You don't follow him, so you are not authorized to see his profile! [Protected timeline]
            self.showAlert(message: "Follow and Try Again.", title: "Sorry, \( followers[indexPath.row].fullName! ) has a protected profile!")
        }else{
        
            /// You are authorized to access his profile
            let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! FollowerDetailsViewController
            
            detailsVC.selectedFollower = followers[indexPath.row]
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
    }
    

    
    //MARK:- Logout button is tapped
    
    @IBAction func logoutIsTapped(_ sender: UIBarButtonItem) {
       
        let alert = UIAlertController(title: "", message: "Do you really want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { action in
            
            self.logout()
            
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { action in
            // perhaps use action.title here
        
            //Do nothing
        
        })
        
        self.present(alert, animated: true, completion: nil)
        
    }
 
 
    //MARK:- perform logout operation
    func logout (){
        
        UserDefaults.standard.removeObject(forKey: ConstantUrls.currentLoggedInUserKey)
        
        if let usersData = UserDefaults.standard.object(forKey: ConstantUrls.loggedinUsersKey) as? Data {
            
            var usersDict = NSKeyedUnarchiver.unarchiveObject(with: usersData) as! [String:User]
            
            usersDict[(loggedUserData?.username)!] = LoginViewController.selectedUser /// as this is updated
            
            //commit updates
            let encodedDict = NSKeyedArchiver.archivedData(withRootObject: usersDict)
            UserDefaults.standard.set(encodedDict, forKey: ConstantUrls.loggedinUsersKey)
            
        }else{
            print("****** ERROR! :: NO LoggedINsDictionary in UserDefaults")
        }
        
        print("Loggedout Successfully . ..")
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
}



//MARK:- Extension for ViewProtocol
extension FollwersTableViewController : FollowersViewProtocol{

    func showProgressBar(){
    
        print("VC:: Viewing progress bar ...")
        
        //1. Network Indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        //2. ProgressBar
        progressBar = showMBProgressBar(view: self.view, title: "Loading Followers List ...")
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
    
    func updateFollowersList(newFollowers: [Follower] ){
    
      //  followers.append(contentsOf: newFollowers)
        followers.insert(contentsOf: newFollowers, at: 0)
    }


}


