//
//  FollowerDetailsDataSource.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

protocol TweetsDataSource {
    
    
    func getTweets(requestValues: TweetsRequestValues,  onSuccess_repo:@escaping([Tweet]) -> Void, onFailure_repo:@escaping (String) -> Void);
    
}
