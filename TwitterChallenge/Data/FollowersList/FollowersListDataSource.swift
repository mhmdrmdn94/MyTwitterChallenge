//
//  FollowersListDataSource.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

protocol FollowersDataSource {
    
    
    func getFollowers(requestValues: FollowersRequestValues,  onSuccess_repo:@escaping([Follower]) -> Void, onFailure_repo:@escaping (String) -> Void);
    
}
