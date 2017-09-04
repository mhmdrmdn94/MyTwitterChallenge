//
//  CoreDataAPI.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 9/4/17.
//
//
import UIKit
import Foundation
import CoreData

class CoreDataOperator{

    
    
    
    //MARK:- Persist Followers List
    static func persistFollowers(forUser userid: String, followersList followers: [Follower]) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "FollowerT",
                                       in: managedContext)!
        
        
        for followerObj in followers {
       
            let follower = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
            
            // 3
            follower.setValue(userid, forKeyPath: "user_id")
            follower.setValue(followerObj.screenName!, forKeyPath: "screen_name")
            follower.setValue(followerObj.profileImage!, forKeyPath: "profile_image")
            follower.setValue(followerObj.protected!, forKeyPath: "is_protected")
            follower.setValue(followerObj.fullName!, forKeyPath: "fullname")
            follower.setValue(followerObj.followerID!, forKeyPath: "follower_id")
            follower.setValue(followerObj.description!, forKeyPath: "desc")
            follower.setValue(followerObj.backgroundmage!, forKeyPath: "bg_image")
            
            
            // 4
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        
        }
        
    }
    
    
    //MARK:- Persist Tweets List
    static func persistTweets(forFollower followerid: String, tweetsList tweets:[Tweet]) {
        
        
        
        
        
        
    }
    
    
    
    
    
    //MARK:- get followers list
    static func fetchFollowersList(byUserId userid: String, onSuccess_coredata:@escaping([NSManagedObject]) -> Void, onFailure_coredata:@escaping (String) -> Void){
        
        var followers : [NSManagedObject] = []
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                onFailure_coredata("Error occured while fetching local data.")
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FollowerT")
        
        //3
        do {
           
            fetchRequest.predicate = NSPredicate(format: "user_id == %@", userid)
            
            followers = try managedContext.fetch(fetchRequest)
            
            for follower in followers{
                
                print(" == = = = == = = == ")
                let name = follower.value(forKey: "fullname") as? String
                print("COREDATA : FOLLOWER>> \(name!)")
            }
       
            
            onSuccess_coredata(followers)
            
        } catch let error as NSError {
            print("Could not fetch followers. \(error), \(error.userInfo)")
            onFailure_coredata("Error occured while fetching local data.")
        }
    }
    
    
    
    //MARK:- get tweets list
    static func fetchTweetsList(byFollowerId followerid: String) -> [NSManagedObject] {
        
        var tweets : [NSManagedObject] = []
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return tweets
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TweetT")
        
        //3
        do {
            
            fetchRequest.predicate = NSPredicate(format: "follower_id == %@", followerid)
            
            tweets = try managedContext.fetch(fetchRequest)
            
            for tweet in tweets{
                
                print(" == = = = == = = == ")
                let text = tweet.value(forKey: "content") as? String
                print("COREDATA : TWEET>> \(text!)")
            }
            
            
        } catch let error as NSError {
            print("Could not fetch tweets. \(error), \(error.userInfo)")
        }
        
        return tweets
    }
    


}
