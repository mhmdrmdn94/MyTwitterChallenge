//
//  FollwersTableViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import UIKit
import TwitterKit

class FollwersTableViewController: UITableViewController {

    
    var loggedUserData : (username: String, userid: String)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        print("Followers List is loaded ...")
        
        self.navigationItem.title = "Your Followers"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        
        
        
        if let logged = loggedUserData{
        
            print("FollowersVC >>> currentID=\(logged)")
            
        }
        
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followerCell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = "I'm the \"\( indexPath.row )\" Follower :)."
        
        
        return cell
    }
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! FollowerDetailsViewController
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    //MARK:- Logout button is tapped
    
    
    
    @IBAction func logoutIsTapped(_ sender: UIBarButtonItem) {
        
        print("Logging out ...")
        
        let store = Twitter.sharedInstance().sessionStore
        store.logOutUserID((self.loggedUserData?.userid)!)
        LoginViewController.updateUserDefaultsLoggedInUsers()
        
        print("Loggedout Successfully . ..")
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
