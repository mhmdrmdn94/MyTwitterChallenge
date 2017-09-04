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
    var localDS : LoginLocalDS?
    
    
    init() {
        remoteDS = LoginRemoteDS()
        localDS = LoginLocalDS()
    }

    
    func getData(requestValues: RequestValues,onSuccess_usecase:@escaping(Any) -> Void, onFailure_usecase:@escaping (String) -> Void){
        
        
        
        // Check Internet Connection
        if InternetReachability.checkInternetConnectionUsingAlamofire() {
        
            print("????? Remotely Getting bearer")
            // get data from RemoteDataSource
            remoteDS?.getBearerToken(requestValues: requestValues as! LoginRequestVlaues, onSuccess_repo: {
                
                responseStr in
                
                //UPDATE UserDefaults value
                UserDefaults.standard.set(responseStr, forKey: ConstantUrls.bearer)
                
                
                onSuccess_usecase(responseStr)
                
            }, onFailure_repo: {
                
                errorStr in
                onFailure_usecase(errorStr)
                
            })
        
        }else{
           
            print("????? Locally Getting bearer")
            
            // get data from LocalDataSource
            localDS?.getBearerToken(requestValues: requestValues as! LoginRequestVlaues, onSuccess_repo: {
                
                responseStr in
                onSuccess_usecase(responseStr)
                
            }, onFailure_repo: {
                
                errorStr in
                onFailure_usecase(errorStr)
                
            })
        
        }
        
        
        
    }

    

}
