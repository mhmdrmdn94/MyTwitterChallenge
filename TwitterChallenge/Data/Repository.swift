//
//  Repository.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/25/17.
//
//

import Foundation

protocol RepositoryProtocol {
    
    func getData(requestValues: RequestValues,onSuccess_usecase:@escaping(Any) -> Void, onFailure_usecase:@escaping (String) -> Void);
    
    
}

