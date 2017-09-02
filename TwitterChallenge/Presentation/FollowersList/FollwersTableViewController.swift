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

    
    var loggedUserData : (username: String, userid: String)?
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
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        
        if let logged = loggedUserData{
        
            print("FollowersVC >>> currentID=\(logged)")
            
            self.presenter?.getFollowers(userid: (loggedUserData?.userid)!)
        }
        
        
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
        followerImage.sd_setImage(with: URL(string: followers[indexPath.row].profileImage!), placeholderImage: UIImage(named: "user_default"))
        
        
        return cell
    }
    
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! FollowerDetailsViewController
        
        detailsVC.selectedFollower = followers[indexPath.row]
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
        
    }
    

    
    //MARK:- Logout button is tapped
    
    @IBAction func logoutIsTapped(_ sender: UIBarButtonItem) {
        
        print("Logging out ...")
       
        // ** update: Do not remove user from sessionStore, Just remove him from UserDefaults
        // this to ensure that recently Logged users sessions do not be removed
        // and to ensure that only current logged in user is in UserDefaults TO Skip loginPage later
        
        
        //let store = Twitter.sharedInstance().sessionStore
        //store.logOutUserID((self.loggedUserData?.userid)!)
        
        UserDefaults.standard.removeObject(forKey: ConstantUrls.currentLoggedInUserKey)
        
        LoginViewController.updateUserDefaultsLoggedInUsers()
        
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
    
        followers = newFollowers
    
    }


}


