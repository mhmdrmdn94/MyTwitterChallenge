//
//  LoginDataSource.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation


protocol LoginDataSource {
    
    
    func getBearerToken(requestValues: LoginRequestVlaues,  onSuccess_repo:@escaping(String) -> Void, onFailure_repo:@escaping (String) -> Void);
    
}
