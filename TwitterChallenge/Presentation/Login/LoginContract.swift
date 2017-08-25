//
//  LoginContract.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import Foundation

protocol LoginViewProtocol {
    
    func showProgressBar();
    func hideProgressBar();
    func showErrorMsg(errorMsg : String);
    func updateView();
    
}


protocol LoginPresenterProtocol {
    
    func loginWithNewAccount(username: String, userid: String); /// Do not forget to store them in NSUserDefaults as this is the FIRST-TIME-LOGIN for this account
    
    func loginWithExistingAccount(userid: String);
    
}
