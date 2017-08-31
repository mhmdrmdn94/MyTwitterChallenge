//
//  BaseTableViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/31/17.
//
//

import UIKit
import MBProgressHUD

class BaseTableViewController: UITableViewController {

   
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

   
    //MARK:- Base functions
    
    
    //MARK:-  ProgresBar initialization func
    
    func showMBProgressBar(view:UIView!,title: String?) -> MBProgressHUD{
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        
        if title == nil{
            hud.label.text = NSLocalizedString("Loading ...", comment: "Loading ...")
        }else{
            hud.label.text = title!
        }
        
        return hud
    }
    
    
    
    //MARK:-  Alert initialization func.
    
    func showAlert(message: String, title: String = "") {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    
    

}
