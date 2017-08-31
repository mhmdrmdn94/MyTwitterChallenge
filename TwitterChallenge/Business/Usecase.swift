//
//  Usecase.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation


protocol UsecaseProtocol {
    
    func executeUseCase(requestValues: RequestValues,onSuccess_preseneter:@escaping(Any) -> Void, onFailure_presenter:@escaping (String) -> Void);
    
    
}




protocol RequestValues {
    
}
