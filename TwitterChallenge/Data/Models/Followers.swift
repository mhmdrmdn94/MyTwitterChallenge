//
//  Followers.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/31/17.
//
//

import Foundation
import SwiftyJSON

class Follower {
    
    var followerID : String?
    var fullName : String?
    var description : String?   //bio
    var screenName : String?    //handle
    var profileImage : String?
    var backgroundmage : String?
    
    init() {
        
    }
    
    init(json: JSON) {
        
        followerID = json["id_str"].stringValue
        fullName = json["name"].stringValue
        description = json["description"].stringValue
        screenName = json["screen_name"].stringValue
        profileImage = json["profile_image_url"].stringValue
        backgroundmage = json["profile_background_image_url"].stringValue
        
    }
    
    
}
