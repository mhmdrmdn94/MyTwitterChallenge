//
//  CoreDataAPI.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 9/4/17.
//
//

import Foundation
import CoreData

class CoreDataOperator{

    
    
    
    //MARK:- Persist Followers List
    static func persistFollowers(forUser userid: String, followersList followers: [Follower]) {
        
        
        
        
        
    }
    
    
    //MARK:- Persist Tweets List
    static func persistTweets(forFollower followerid: String, tweetsList tweets:[Tweet]) {
        
        
        
        
        
        
    }
    
    
    
    
    
    //MARK:- get followers list
    static func fetchFollowersList(byUserId userid: String) -> [NSManagedObject] {
        
        var followers : [NSManagedObject] = []
        
        
        
        
        return followers
    }
    
    
    
    //MARK:- get tweets list
    static func fetchTweetsList(byFollowerId followerid: String) -> [NSManagedObject] {
        
        var tweets : [NSManagedObject] = []
        
        
        
        
        
        return tweets
    }
    


}
