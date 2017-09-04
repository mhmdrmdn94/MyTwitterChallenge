//
//  FollowerDetailsRepository.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation


class TweetsRepository : RepositoryProtocol{

    
    var remoteDS : TweetsRemoteDS?
    var localDS : TweetsLocalDS?
    
    
    init() {
        remoteDS = TweetsRemoteDS()
        localDS = TweetsLocalDS()
    }
    
    
    func getData(requestValues: RequestValues,onSuccess_usecase:@escaping(Any) -> Void, onFailure_usecase:@escaping (String) -> Void){
    
        
        
        // Check Internet Connection
        if InternetReachability.checkInternetConnectionUsingAlamofire() {
            
            // get data from RemoteDataSource
            print("????? Remotely Getting tweets")
       
            
            remoteDS?.getTweets(requestValues: requestValues as! TweetsRequestValues, onSuccess_repo: {
                
                responseArr in
                
                //1. update local tweets
                let reqVal = requestValues as! TweetsRequestValues
                CoreDataOperator.persistTweets(forFollower: reqVal.followerID!, tweetsList: responseArr)
                
                //2. populate new data to the view
                onSuccess_usecase(responseArr)
                
            }, onFailure_repo: {
                
                errorStr in
                onFailure_usecase(errorStr)
                
            })
            
            
            
            
            
        }else{
            // get data from LocalDataSource
            print("????? Locally Getting tweets")
            
        
            localDS?.getTweets(requestValues: requestValues as! TweetsRequestValues, onSuccess_repo: {
                
                responseArr in
                
                //1. update local tweets
                let reqVal = requestValues as! TweetsRequestValues
                CoreDataOperator.persistTweets(forFollower: reqVal.followerID!, tweetsList: responseArr)
                
                //2. populate new data to the view
                onSuccess_usecase(responseArr)
                
            }, onFailure_repo: {
                
                errorStr in
                onFailure_usecase(errorStr)
                
            })
            
        
        }
        
        
    
    
    
    }
    

}
