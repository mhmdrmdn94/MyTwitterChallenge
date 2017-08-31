//
//  BaseExtensions.swift
//  TwitterChallenge
//
//  Created by MRamadan@ntg on 8/31/17.
//
//

import Foundation


////// Extension for String to add base64Method

extension String{
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}
