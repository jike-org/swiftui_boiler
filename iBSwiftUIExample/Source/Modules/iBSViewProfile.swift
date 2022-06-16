//
//  iBSViewProfile.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSViewProfileDelegate {
    
    @objc optional func viewProfileInfoNetworkRequest(completion: @escaping iBSCompletionHandlerWithData)
}

public class iBSViewProfile: iBSBase {
    
    public var delegate: iBSViewProfileDelegate?
    
    
    //MARK: Proceed with View Profile API
    public func viewProfileInfoNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Get Profile web service call
        ProfileAPI.profileGet() { (response, error) in
            
            if error != nil {
                // Handle error
                self.hadleErrorResponse(error, completion: { (status, statusCode, message) in
                    completion(status, statusCode, message, nil)
                })
            } else {
                guard let payload = response?.payload else {return}
                
                // Get payload as readable object
                let payloadDictionary: PayloadDictionary = (payload.value as? PayloadDictionary) ?? [:]
                
                completion(true, 200, response?.message ?? "success", payloadDictionary)
            }
        }
    }
}
