//
//  FollowersDetailsPresenter.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import Foundation

class TweetsPresenter : TweetsPresenterProtocol{

    
    var view : TweetsViewProtocol?
    var usecase : TweetsUsecase?
    
    required init(view: TweetsViewProtocol) {
        
        self.view = view
        let repo = TweetsRepository()
        self.usecase = TweetsUsecase(repo: repo)
    }
    
    
    func getTweets(followerID: String){
    
        
        self.view?.showProgressBar()
        
        let requestValues = TweetsRequestValues(followerID: followerID)
        
        usecase?.executeUseCase(requestValues: requestValues, onSuccess_preseneter: {
        
            responseAny in
            
                let tweetsArr = responseAny as! [Tweet]
                self.view?.hideProgressBar()
                self.view?.updateTweetsList(newTweets: tweetsArr)
            
        }, onFailure_presenter: {
        
            errorStr in
                self.view?.hideProgressBar()
                self.view?.showErrorMsg(errorMsg: errorStr)
        
        })
    
    
    }



}
