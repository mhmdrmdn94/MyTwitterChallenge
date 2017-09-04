//
//  Tweets.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/31/17.
//
//

import Foundation
import SwiftyJSON

class Tweet {
    
    var tweetID : String?
    var content : String? //text
    
    var createdAt : String?
    var retweets : Int?
    var favourites : Int?
    
    init() {
        
    }
    
    init(json: JSON) {
        
        tweetID = json["id_str"].stringValue
        content = json["text"].stringValue
        createdAt = json["created_at"].stringValue
        retweets = json["retweet_count"].intValue
        favourites = json["favorite_count"].intValue
        
        print("=== \(retweets!) ::: \(favourites!)")
    }
    
    
}
