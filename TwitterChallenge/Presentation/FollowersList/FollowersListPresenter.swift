//
//  FollowersListPresenter.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import Foundation

class FollowersPresenter: FollowersPresenterProtocol {
    
    
    var view : FollowersViewProtocol?
    var usecase : FollowersUsecase?
    
    
    required init(view: FollowersViewProtocol) {
        
        self.view = view
        let repo = FollowersRepository()
        self.usecase = FollowersUsecase(repo: repo)
        
    }
    
    
    func getFollowers(userid: String){
    
        self.view?.showProgressBar()
        
        let requestValues = FollowersRequestValues(loggedUserID: userid)
        
        
        usecase?.executeUseCase(requestValues: requestValues, onSuccess_preseneter: {
            responseAny in
            
            let followersList = responseAny as! [Follower]
            self.view?.hideProgressBar()
            self.view?.updateFollowersList(newFollowers: followersList)
            
        
        }, onFailure_presenter: {
        
            errorStr in
            self.view?.hideProgressBar()
            self.view?.showErrorMsg(errorMsg: errorStr)
        
        })
    
    
    }
    
    
}
