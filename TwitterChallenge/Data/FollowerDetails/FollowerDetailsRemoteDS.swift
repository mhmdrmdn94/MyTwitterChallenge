//
//  FollowerDetailsRemoteDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation
import SwiftyJSON
import Alamofire

class TweetsRemoteDS : TweetsDataSource {
    
    
    let alamofireSharedInstance = AlamofireAPI.sharedInstance
    
    
    func getTweets(requestValues: TweetsRequestValues,  onSuccess_repo:@escaping([Tweet]) -> Void, onFailure_repo:@escaping (String) -> Void){
    
        
        
        //1. prepare the urlToBeHit
        let url = ConstantUrls.baseURL + ConstantUrls.tweetsURL + requestValues.followerID!
        
        //2. prepare the request params
        //3. prepare the request headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(ConstantUrls.bearerToken)"
        ]
        
        //4. make your api request
        alamofireSharedInstance.executeGetRequest(url: url, parameters: nil, header: headers, onSuccess: {
        
            responseAny in
            
            var tweets : [Tweet] = []
            
            let json = responseAny as! JSON
            
            let tweetsArr = json.array!
            
            for tweetJson in tweetsArr{
                
                let tweetObj = Tweet(json: tweetJson)
                tweets.append(tweetObj)
            }
            
            onSuccess_repo(tweets)
        
        }, onFailure: {
        
            errorObj in
            onFailure_repo(errorObj.localizedDescription)
        
        })
        
        
    
    
    }
    
}
