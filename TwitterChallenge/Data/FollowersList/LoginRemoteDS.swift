//
//  LoginRemoteDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation
import Alamofire

class LoginRemoteDS : LoginDataSource {
    
    let alamofireSharedInstance = AlamofireAPI.sharedInstance
    
    
    func getBearerToken(requestValues: LoginRequestVlaues,  onSuccess_repo:@escaping(String) -> Void, onFailure_repo:@escaping (String) -> Void){
    
        
        
        //1. prepare the urlToBeHit
        let url = ConstantUrls.baseURL + ConstantUrls.bearerURL
        
        print("^^ \(url)")
        
        
        //2. prepare the request headers
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(ConstantUrls.encodedToken)",
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        ]
    
        
        //2. prepare the request params
        let parameters: Parameters = ["grant_type": "client_credentials"]

        
        //4. make your api request
        alamofireSharedInstance.executePostRequest(url: url, parameters: parameters, header: headers, onSuccess: {
        
            responseAny in
            
                /// Extract your data and parse it to string
            
            
                onSuccess_repo("I am BEARER :)")
        
        }, onFailure: {
        
            errorObj in
                onFailure_repo(errorObj.localizedDescription)
        })
    
    }
    
}
