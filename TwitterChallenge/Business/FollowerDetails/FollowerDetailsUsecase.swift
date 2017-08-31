//
//  FollowerDetailsUsecase.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

struct TweetsUsecase : UsecaseProtocol{

    
    var repo : TweetsRepository?
    
    func executeUseCase(requestValues: RequestValues,onSuccess_preseneter:@escaping(Any) -> Void, onFailure_presenter:@escaping (String) -> Void){
    
        
        repo?.getData(requestValues: requestValues, onSuccess_usecase: {
        
            responseAny in
            onSuccess_preseneter(responseAny)
            
        }, onFailure_usecase: {
        
            errorStr in
            onFailure_presenter(errorStr)
        })
        
    
    
    }
    

}


//MARK:- Implement FollowersListRequestValues

struct TweetsRequestValues : RequestValues {
    
    var followerID : String?
    
}
