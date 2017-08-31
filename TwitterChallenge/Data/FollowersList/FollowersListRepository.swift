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
    
        
        remoteDS?.getFollowers(requestValues: requestValues as! FollowersRequestValues, onSuccess_repo: {
        
            responseArr in
                onSuccess_usecase(responseArr)
            
        }, onFailure_repo: {
        
            errorStr in
                onFailure_usecase(errorStr)
        
        })
        
    
    
    }
    

    
}
