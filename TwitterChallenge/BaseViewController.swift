//
//  BaseViewController.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import UIKit
import MBProgressHUD
import TwitterKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


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
