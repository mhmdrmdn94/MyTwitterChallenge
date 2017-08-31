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
    func updateBearerTokenValue(bearer: String);
    
}


protocol LoginPresenterProtocol {
    
    func getBearerToken(encodedKeys: String);
    
}
