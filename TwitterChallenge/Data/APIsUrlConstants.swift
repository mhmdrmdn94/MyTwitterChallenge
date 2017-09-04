//
//  APIsUrlConstants.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/27/17.
//
//

import Foundation

struct ConstantUrls {
   
    
    /// NSUserDefaults
    static let loggedinUsersKey = "RECENT_USERS"
    static let currentLoggedInUserKey = "CURRENT_LOGGEDIN_USER"
    
    /// BackendIntegration
    static let consumerKey = "xf29D7ZLIAcfB9NUkfzvlBGbt"
    static let consumerSecret = "zXbeXSQmB9zQ4mTDpzYYgjQLVvMGwpX8McdkbL93vaAH4f7lba"
    static let unEncodedToken = "xf29D7ZLIAcfB9NUkfzvlBGbt:zXbeXSQmB9zQ4mTDpzYYgjQLVvMGwpX8McdkbL93vaAH4f7lba"
    
    static let encodedToken = ConstantUrls.unEncodedToken.toBase64()
    
    static var bearerToken = ""
    
    static let baseURL = "https://api.twitter.com"
    static let bearerURL = "/oauth2/token"
    static let followersURL = "/1.1/followers/list.json?user_id="
    static let tweetsURL = "/1.1/statuses/user_timeline.json?count=10&user_id="
    
    
}
