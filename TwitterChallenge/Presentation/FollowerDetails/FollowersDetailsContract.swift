//
//  FollowersDetailsContract.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import Foundation


protocol TweetsViewProtocol {
    
    func showProgressBar();
    func hideProgressBar();
    func showErrorMsg(errorMsg : String);
    func updateTweetsList(newTweets: [Tweet] );
    
}


protocol TweetsPresenterProtocol {
    
    func getTweets(userid: String);
    
}
