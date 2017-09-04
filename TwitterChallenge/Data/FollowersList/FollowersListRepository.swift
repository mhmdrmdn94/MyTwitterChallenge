//
//  FollowersListRepository.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

class FollowersRepository: RepositoryProtocol {
    
    
    var remoteDS : FollowersRemoteDS?
    var localDS : FollowersLocalDS?
    
    
    init() {
        remoteDS = FollowersRemoteDS()
        localDS = FollowersLocalDS()
    }
    
    
    func getData(requestValues: RequestValues,onSuccess_usecase:@escaping(Any) -> Void, onFailure_usecase:@escaping (String) -> Void){
    
        
        
        // Check Internet Connection
        if InternetReachability.checkInternetConnectionUsingAlamofire() {
         
            // get data from RemoteDataSource
            print("????? Remotely Getting followers")
            
            
            remoteDS?.getFollowers(requestValues: requestValues as! FollowersRequestValues, onSuccess_repo: {
                
                responseArr in
                
                
                //////1. Update the local data
                let reqValues  = requestValues as! FollowersRequestValues
                CoreDataOperator.persistFollowers(forUser: reqValues.loggedUserID!, followersList: responseArr)
                
                //////2. populate fetched data to the view
                onSuccess_usecase(responseArr)
                
            }, onFailure_repo: {
                
                errorStr in
                onFailure_usecase(errorStr)
                
            })
            
            
            
        }else{
            
            // get data from LocalDataSource
            print("????? Locally Getting followers")
            
            localDS?.getFollowers(requestValues: requestValues as! FollowersRequestValues, onSuccess_repo: {
                
                responseArr in
                onSuccess_usecase(responseArr)
                
            }, onFailure_repo: {
                
                errorStr in
                onFailure_usecase("Something occured while fetching from cach memory!")
                
            })
            
            
            
        }
        
        
    
    
    }
    

    
}
