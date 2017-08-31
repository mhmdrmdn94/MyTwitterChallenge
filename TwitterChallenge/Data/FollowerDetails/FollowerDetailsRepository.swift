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
    
        
        remoteDS?.getTweets(requestValues: requestValues as! TweetsRequestValues, onSuccess_repo: {
        
            responseArr in
            onSuccess_usecase(responseArr)
        
        }, onFailure_repo: {
        
            errorStr in
            onFailure_usecase(errorStr)
        
        })
        
    
    
    
    }
    

}
