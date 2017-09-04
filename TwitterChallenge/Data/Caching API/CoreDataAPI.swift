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
        
        
        for followerObj in followers {
       
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            // 2
            let entity =
                NSEntityDescription.entity(forEntityName: "FollowerT",
                                           in: managedContext)!
            
            ////// before inserting new follower to coredata, 
            //////     Check if it already exists in coredata to avoid duplicates
            
            let haveDuplicates = CoreDataOperator.checkForDuplicates(inFollowers: followerObj.followerID!)
            
            if haveDuplicates{
                continue
            }
            
            
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
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        for tweetObj in tweets {
            
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            // 2
            let entity =
                NSEntityDescription.entity(forEntityName: "TweetT",
                                           in: managedContext)!
            
            ////// before inserting new follower to coredata,
            //////     Check if it already exists in coredata to avoid duplicates
            
            let haveDuplicates = CoreDataOperator.checkForDuplicates(inTweets: tweetObj.tweetID!)
            
            if haveDuplicates{
                continue
            }
            
            
            let tweet = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
            
            // 3
            tweet.setValue(followerid, forKeyPath: "follower_id")
            tweet.setValue(tweetObj.retweets!, forKeyPath: "retweets")
            tweet.setValue(tweetObj.tweetID!, forKeyPath: "tweet_id")
            tweet.setValue(tweetObj.favourites, forKeyPath: "favourites")
            tweet.setValue(tweetObj.createdAt!, forKeyPath: "created_at")
            tweet.setValue(tweetObj.content!, forKeyPath: "content")
            
            
            // 4
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
        
        
        
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
    static func fetchTweetsList(byFollowerId followerid: String, onSuccess_coredata:@escaping([NSManagedObject]) -> Void, onFailure_coredata:@escaping (String) -> Void){
        
        var tweets : [NSManagedObject] = []
        
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
            NSFetchRequest<NSManagedObject>(entityName: "TweetT")
        
        
        //3
        do {
            fetchRequest.predicate = NSPredicate(format: "follower_id == %@", followerid)
            //request.sortDescriptors = [NSSortDescriptor(key: "", ascending: false)]
            //fetchRequest.fetchLimit = 10
            tweets = try managedContext.fetch(fetchRequest)
            
            for tweet in tweets{
                
                print(" == = = = == = = == ")
                let text = tweet.value(forKey: "content") as? String
                print("COREDATA : TWEET>> \(text!)")
            }
            
            
            onSuccess_coredata(tweets)
            
            
        } catch let error as NSError {
            print("Could not fetch followers. \(error), \(error.userInfo)")
            onFailure_coredata("Error occured while fetching local data.")
        }
       
    }
    
    
    
    //MARK:- Remove duplicated
    
    static func checkForDuplicates( inFollowers followerid: String) -> Bool {
        
        var isDuplicate = false
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return isDuplicate
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FollowerT")
        
        //3
        do {
            
            fetchRequest.predicate = NSPredicate(format: "follower_id == %@", followerid)
            
            let results = try managedContext.fetch(fetchRequest)

            if results.isEmpty{
                isDuplicate = false
            }else{
                isDuplicate = true
            }

        } catch let error as NSError {
            print("Could not fetch followers. \(error), \(error.userInfo)")
        }
        
        
        return isDuplicate
        
    }
    
    
    static func checkForDuplicates(inTweets tweetid: String) -> Bool {
        
        var isDuplicate = false
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return isDuplicate
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TweetT")
        
        //3
        do {
            
            fetchRequest.predicate = NSPredicate(format: "tweet_id == %@", tweetid)
            
            let results = try managedContext.fetch(fetchRequest)
            
            if results.isEmpty{
                isDuplicate = false
            }else{
                isDuplicate = true
            }
            
        } catch let error as NSError {
            print("Could not fetch followers. \(error), \(error.userInfo)")
        }
        
        
        return isDuplicate
        
    }
    


}
