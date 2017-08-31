//
//  AlamofireAPI.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/31/17.
//
//

import Foundation
import SystemConfiguration
import Alamofire
import SwiftyJSON

struct AlamofireAPI: BackendAPI {
    
    //MARK: Shared Instance using Singleton
    static let sharedInstance =  AlamofireAPI()
    
    
    private init() { /// to prevent constructing objects
        
    }
    
    
    //MARK:- for GET requests
    
    func executeGetRequest(url:String,parameters: [String:Any]?,header : [String:String]?,onSuccess:@escaping (Any) -> Void, onFailure:@escaping (Error) -> Void){
    
    
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: header ).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
                
            case .success( _):
                
                
                let json = JSON(response.result.value!)
                print("JSON: \(json)")
                
                onSuccess(json)
                
            case .failure(let error):
                print(" # # # \(error.localizedDescription)")
                onFailure(error)
                
            }

        }

    
    }

    
    
    //MARK:- for POST requests

    func executePostRequest(url:String,parameters: [String:Any]?,header : [String:String]?,onSuccess:@escaping (Any) -> Void, onFailure:@escaping (Error) -> Void){
    
        
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header ).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
                
            case .success( _):
                
                
                let json = JSON(response.result.value!)
                print("JSON: \(json)")
                
                onSuccess(json)
                
            case .failure(let error):
                print(" # # # \(error.localizedDescription)")
                onFailure(error)
                
            }

            
        }
    
    }
    
    
    
    
    //MARK:- Check Internet Connection
    
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    
}
