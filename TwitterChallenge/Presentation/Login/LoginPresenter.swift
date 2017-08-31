//
//  LoginPresenter.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/24/17.
//
//

import Foundation

class LoginPresenter : LoginPresenterProtocol{

    
    var view : LoginViewProtocol?
    var usecase : LoginUsecase?

    
    required init(view: LoginViewProtocol) {
    
        self.view = view
        let repo = LoginRepository()
        self.usecase = LoginUsecase(repo: repo)
    }
    
    func getBearerToken(encodedKeys: String){
    
        self.view?.showProgressBar()
        
        let requestValues = LoginRequestVlaues(encodedKeys: encodedKeys)
        
        usecase?.executeUseCase(requestValues: requestValues, onSuccess_preseneter: {
        
            responseAny in
                let responseStr = responseAny as! String
                self.view?.hideProgressBar()
                self.view?.updateBearerTokenValue(bearer: responseStr)
        
        }, onFailure_presenter: {
        
            errorStr in
            self.view?.hideProgressBar()
            self.view?.showErrorMsg(errorMsg: errorStr)
        
        })
    
    
    }

}
