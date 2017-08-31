//
//  LoginRepository.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

class LoginRepository : RepositoryProtocol{

    
    var remoteDS : LoginRemoteDS?
    
    init() {
        remoteDS = LoginRemoteDS()
    }

    
    func getData(requestValues: RequestValues,onSuccess_usecase:@escaping(Any) -> Void, onFailure_usecase:@escaping (String) -> Void){
        
        
        
        remoteDS?.getBearerToken(requestValues: requestValues as! LoginRequestVlaues, onSuccess_repo: {
        
            responseStr in
            onSuccess_usecase(responseStr)
            
        }, onFailure_repo: {
        
            errorStr in
            onFailure_usecase(errorStr)
        
        })
        
    }

    

}
