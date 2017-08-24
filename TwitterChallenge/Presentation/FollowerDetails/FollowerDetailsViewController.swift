//
//  FollowerDetailsViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import UIKit

class FollowerDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tweetsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("FollowerDetails screen is loaded...")
    }

    
    
    
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = "\"\( indexPath.row )\" Tweeeeeeet :)."
        
        
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
