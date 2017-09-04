//
//  FollowerDetailsViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import UIKit
import MBProgressHUD
import WHRoundedImageView
import SDWebImage

class FollowerDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tweetsTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var usenameLabel: UILabel!
    @IBOutlet weak var profileImage: WHRoundedImageView!
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    
    var progressBar : MBProgressHUD?
    var presenter : TweetsPresenterProtocol?
    var selectedFollower : Follower?
    var tweets : [Tweet] = []{
    
        didSet{
            self.tweetsTableView.reloadData()
            print("Tweets TableView is updated ...")
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("FollowerDetails screen is loaded...")
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 300

        
        self.presenter = TweetsPresenter(view: self)
        
        self.tweetsTableView.addSubview(self.refreshControl)
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        ///// Reload the profile pic, background pic and handle
        //1.
        print("=== \((selectedFollower?.backgroundmage!)!)")
        let bgURL = URL(string: (selectedFollower?.backgroundmage!)!)
        backgroundImage.sd_setImage(with: bgURL, placeholderImage: UIImage(named: "background_default"))
        
        //2.
        let profileURL = URL(string: (selectedFollower?.profileImage!)!)
        profileImage.sd_setImage(with: profileURL, placeholderImage: UIImage(named: "profile_default"))
        
        
        //3.
        usenameLabel.text = "@\(String(describing: selectedFollower?.screenName!))"
        
        
        /// get tweets
        self.presenter?.getTweets(followerID: (selectedFollower?.followerID!)!)
        
        
    }
    
    
    //MARK:- Handle tableView refresh
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        print("REFRESHING . ...");
      
        /// get tweets
        self.presenter?.getTweets(followerID: (selectedFollower?.followerID!)!)
        
        refreshControl.endRefreshing()
    }
    
    
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return tweets.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        // Configure the cell...
        
        let tweetText = cell.viewWithTag(1) as! UILabel
        let tweetDate = cell.viewWithTag(2) as! UILabel
        let tweetFav = cell.viewWithTag(4) as! UILabel
        let tweetRet = cell.viewWithTag(3) as! UILabel
        
        print(" ---- \( tweets[indexPath.row].retweets! ) :: \( tweets[indexPath.row].favourites! ) ")
        
        tweetText.text = tweets[indexPath.row].content!
        tweetDate.text = tweets[indexPath.row].createdAt!
        tweetFav.text = "\( tweets[indexPath.row].favourites! )"
        tweetRet.text = "\( tweets[indexPath.row].retweets! )"
        
        
        return cell
    }


    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            return "Recent Tweets:"
        }else{
            return ""
        }
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK:- Extension for ViewProtocol
extension FollowerDetailsViewController : TweetsViewProtocol{

    
    func showProgressBar(){
        
        print("VC:: Viewing progress bar ...")
        
        //1. Network Indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        //2. ProgressBar
        progressBar = showMBProgressBar(view: self.view, title: "Loading RecentTweets...")
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
    
    
    func updateTweetsList(newTweets: [Tweet] ){
    
        print("Updating Tweets ...")
        tweets = newTweets
    
    }


}



