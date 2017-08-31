//
//  FollowersListRemoteDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation
import Alamofire

class FollowersRemoteDS: FollowersDataSource {
    
    
    let alamofireSharedInstance = AlamofireAPI.sharedInstance
    
    func getFollowers(requestValues: FollowersRequestValues,  onSuccess_repo:@escaping([Follower]) -> Void, onFailure_repo:@escaping (String) -> Void){
    
        
        //1. prepare the urlToBeHit
        let url = ConstantUrls.baseURL + ConstantUrls.followersURL + requestValues.loggedUserID!
        
        //2. prepare the request params
        //3. prepare the request headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(ConstantUrls.bearerToken)"
        ]
        
        //4. make your api request
        alamofireSharedInstance.executeGetRequest(url: url, parameters: nil, header: headers, onSuccess: {
        
            responseAny in
            
            let followers : [Follower] = []
            var dummy = Follower(); dummy.followerID = "I am from backend :)"
            /// parse data to followers array
            
                onSuccess_repo(followers)
        
        }, onFailure: {
        
            errorObj in
                onFailure_repo(errorObj.localizedDescription)
        })
        
        
        
    
    
    
    }
    
    
}
