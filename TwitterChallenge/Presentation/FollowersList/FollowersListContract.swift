//
//  FollowersListContract.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import Foundation

protocol FollowersViewProtocol {
    
    func showProgressBar();
    func hideProgressBar();
    func showErrorMsg(errorMsg : String);
    func updateFollowersList(newFollowers: [Follower] );
    
}


protocol FollowersPresenterProtocol {
    
    func getFollowers(userid: String, isFromLogin: Bool);
    
}
