//
//  LoginRemoteDS.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginRemoteDS : LoginDataSource {
    
    let alamofireSharedInstance = AlamofireAPI.sharedInstance
    
    
    func getBearerToken(requestValues: LoginRequestVlaues,  onSuccess_repo:@escaping(String) -> Void, onFailure_repo:@escaping (String) -> Void){
    
        
        
        //1. prepare the urlToBeHit
        let url = ConstantUrls.baseURL + ConstantUrls.bearerURL
        
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
            
                var json = responseAny as! JSON
            
                if json["token_type"].string != nil {
                    
                    if  json["token_type"].string! == "bearer"{
                    
                        let bearerToken = json["access_token"].string!
          
                        onSuccess_repo(bearerToken)
          
                    }else{
                        onFailure_repo("Something went wrong!")
                    }
                    
                } else {
                    
                    print(json["token_type"].error!) // does not exist"
                    onFailure_repo("Something went wrong!")
                }
            
            
        }, onFailure: {
        
            errorObj in
                onFailure_repo(errorObj.localizedDescription)
        })
    
    }
    
}
