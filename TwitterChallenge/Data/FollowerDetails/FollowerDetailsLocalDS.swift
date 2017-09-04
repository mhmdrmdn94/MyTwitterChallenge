//
//  FollowerDetailsLocalDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

class TweetsLocalDS : TweetsDataSource {
    
    
    init() {
        
    }
    
    
    func getTweets(requestValues: TweetsRequestValues,  onSuccess_repo:@escaping([Tweet]) -> Void, onFailure_repo:@escaping (String) -> Void){
    
        
        CoreDataOperator.fetchTweetsList(byFollowerId: requestValues.followerID!, onSuccess_coredata: {
        
            responseMgdArr in
            
            var tweets : [Tweet] = []
            
            for mngdObj in responseMgdArr{
            
                let tweetObj = Tweet()
                
                tweetObj.tweetID = mngdObj.value(forKey: "tweet_id") as? String
                tweetObj.retweets = mngdObj.value(forKey: "retweets") as? Int
                tweetObj.favourites = mngdObj.value(forKey: "favourites") as? Int
                tweetObj.createdAt = mngdObj.value(forKey: "created_at") as? String
                tweetObj.content = mngdObj.value(forKey: "content") as? String
                
                tweets.append(tweetObj)
            
            }
            
            onSuccess_repo(tweets)
        
        }, onFailure_coredata: {
        
            errorStr in
            onFailure_repo(errorStr)
        
        })
        
        
    }
    
}
