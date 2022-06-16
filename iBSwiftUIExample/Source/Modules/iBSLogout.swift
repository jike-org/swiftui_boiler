//
//  iBSiBSLogout.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSLogoutDelegate {
    
    @objc optional func userLogoutNetworkRequest(completion: @escaping iBSCompletionHandler)
}

public class iBSLogout: iBSBase {
    
    public var delegate: iBSLogoutDelegate?
    
    
    //MARK: Proceed with Logout User API
    public func userLogoutNetworkRequest(completion: @escaping iBSCompletionHandler) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet)
            return
        }
        
        // Get Profile web service call
        AuthAPI.logoutGet() { (response, error) in
            
            if error != nil {
                // Handle error
                self.hadleErrorResponse(error, completion: { (status, statusCode, message) in
                    completion(status, statusCode, message)
                })
            } else {
                guard let message = response?.message else {return}
                
                // Remove access token from user defaults
                iBSUserDefaults.removeAccessToken()
                
                completion(true, 200, message)
            }
        }
    }
}
