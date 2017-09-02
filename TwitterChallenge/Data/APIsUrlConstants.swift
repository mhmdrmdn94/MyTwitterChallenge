//
//  APIsUrlConstants.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/27/17.
//
//

import Foundation

struct ConstantUrls {
    
    
    static let consumerKey = "xf29D7ZLIAcfB9NUkfzvlBGbt"
    static let consumerSecret = "zXbeXSQmB9zQ4mTDpzYYgjQLVvMGwpX8McdkbL93vaAH4f7lba"
    static let unEncodedToken = "xf29D7ZLIAcfB9NUkfzvlBGbt:zXbeXSQmB9zQ4mTDpzYYgjQLVvMGwpX8McdkbL93vaAH4f7lba"
    
    static let encodedToken = ConstantUrls.unEncodedToken.toBase64()
    
    static var bearerToken = ""
    
    
    static let loggedinsKey = "LOGGED_INs"
    static let currentLoggedInUserKey = "CURRENT_USER"
    
    static let baseURL = "https://api.twitter.com"
    static let bearerURL = "/oauth2/token"
    static let followersURL = "/1.1/followers/list.json?user_id="
    static let tweetsURL = "/1.1/statuses/user_timeline.json?user_id="
    
    
}
