//
//  FollowerDetailsViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import UIKit
import MBProgressHUD

class FollowerDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tweetsTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usenameLabel: UILabel!
    
    
    
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
        
        self.presenter = TweetsPresenter(view: self)
        
        
        
        //Testing block
        var tweetDummy = Tweet(); tweetDummy.tweetID = "Hello :)"
        
        tweets.append(tweetDummy)
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        ///// Reload the profile pic and background pic
        
        
        
        
        /// get tweets
        self.presenter?.getTweets(followerID: "3019552516")
        
        
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
        
        cell.textLabel?.text = tweets[indexPath.row].tweetID!
        
        
        
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



