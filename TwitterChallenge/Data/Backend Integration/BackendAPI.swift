//
//  BackendAPI.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/31/17.
//
//

import Foundation


protocol BackendAPI{
    
    func executePostRequest(url:String,parameters: [String:Any]?,header : [String:String]?,onSuccess:@escaping (Any) -> Void, onFailure:@escaping (Error) -> Void)
    
    func executeGetRequest(url:String,parameters: [String:Any]?,header : [String:String]?,onSuccess:@escaping (Any) -> Void, onFailure:@escaping (Error) -> Void)
    
}
