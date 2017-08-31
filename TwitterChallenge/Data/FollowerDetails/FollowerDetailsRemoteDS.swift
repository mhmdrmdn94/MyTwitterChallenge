//
//  FollowerDetailsRemoteDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation
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
            
            var test = Tweet(); test.tweetID = "New Coming tweeeeeet :)"; tweets.append(test)
            
            onSuccess_repo(tweets)
        
        }, onFailure: {
        
            errorObj in
            onFailure_repo(errorObj.localizedDescription)
        
        })
        
        
    
    
    }
    
}
