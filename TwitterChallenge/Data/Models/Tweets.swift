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
    
    init() {
        
    }
    
    init(json: JSON) {
        
        tweetID = json["id_str"].stringValue
        content = json["text"].stringValue
    }
    
    
}
