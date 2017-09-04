//
//  Users.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 9/3/17.
//
//

import Foundation

class User : NSObject, NSCoding {

    var username : String
    var userid : String
    var prevCursor : String
    var nextCursor : String

    init(username: String, userid: String, prevCursor: String, nextCursor: String) {
        
        self.username = username
        self.userid = userid
        self.prevCursor = prevCursor
        self.nextCursor = nextCursor
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObject(forKey: "username") as! String
        userid = aDecoder.decodeObject(forKey: "userid") as! String
        prevCursor = aDecoder.decodeObject(forKey: "prevCursor") as! String
        nextCursor = aDecoder.decodeObject(forKey: "nextCursor") as! String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userid, forKey: "userid")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(prevCursor, forKey: "prevCursor")
        aCoder.encode(nextCursor, forKey: "nextCursor")
    }
    
    
}
