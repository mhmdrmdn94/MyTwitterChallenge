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
    var protected : Bool?     //to check if i am able to access his timeline
    
    init() {
        
    }
    
    init(json: JSON) {
        
        followerID = json["id_str"].stringValue
        fullName = json["name"].stringValue
        description = json["description"].stringValue
        screenName = json["screen_name"].stringValue
        profileImage = json["profile_image_url_https"].stringValue
        
        //getting a high quality profile image for a nice list appearance!
        //profileImage = profileImage?.replacingOccurrences(of: "_normal", with: "_bigger") //does no have good appearance
        profileImage = profileImage?.replacingOccurrences(of: "_normal", with: "")
        
        backgroundmage = json["profile_background_image_url_https"].stringValue
        protected = json["protected"].boolValue
        
    }
    
    
}
