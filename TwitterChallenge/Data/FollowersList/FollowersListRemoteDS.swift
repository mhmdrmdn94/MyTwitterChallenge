//
//  FollowersListRemoteDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class FollowersRemoteDS: FollowersDataSource {
    
    
    let alamofireSharedInstance = AlamofireAPI.sharedInstance
    
    func getFollowers(requestValues: FollowersRequestValues,  onSuccess_repo:@escaping([Follower]) -> Void, onFailure_repo:@escaping (String) -> Void){
    
        
        //1. prepare the urlToBeHit
        var url = ConstantUrls.baseURL + ConstantUrls.followersURL + requestValues.loggedUserID!
        
        //2. prepare the request params
        //3. prepare the request headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(ConstantUrls.bearerToken)"
        ]
    
        if LoginViewController.selectedUser.nextCursor != "0"{
        
            url += "&cursor=" + LoginViewController.selectedUser.nextCursor
        
        }
        
        
        
        print(">>>> \(url)")
        
        //4. make your api request
        alamofireSharedInstance.executeGetRequest(url: url, parameters: nil, header: headers, onSuccess: {
        
            responseAny in
            
            var followers : [Follower] = []
            
            let json = responseAny as! JSON
            
            let usersArr = json["users"].arrayValue
            
            for userJson in usersArr{
            
                let followerObj = Follower(json: userJson)
                followers.append(followerObj)
                
            }
            
            //Extract next and prev cursor values, they are important in case of refreshing followersList
            let nxtCursor = json["next_cursor_str"].stringValue
            let prevCursor = json["previous_cursor_str"].stringValue
            
            LoginViewController.selectedUser.nextCursor = nxtCursor
            LoginViewController.selectedUser.prevCursor = prevCursor
            
            
            
            onSuccess_repo(followers)
        
        }, onFailure: {
        
            errorObj in
                onFailure_repo(errorObj.localizedDescription)
        })
        
        
        
    
    
    
    }
    
    
}
