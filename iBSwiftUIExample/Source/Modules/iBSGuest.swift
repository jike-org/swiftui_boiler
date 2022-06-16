//
//  iBSGuest.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSGuestDelegate {
    
    @objc optional func viewGuestDataNetworkRequest(completion: @escaping iBSCompletionHandlerWithData)
}

public class iBSGuest: iBSBase {
    
    public var delegate: iBSGuestDelegate?
    
    
    //MARK: Proceed with View Guest Data API
    public func viewGuestDataNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Get Guest data web service call
        GuestAPI.guestsGet() { (response, error) in
            
            if error != nil {
                // Handle error
                self.hadleErrorResponse(error, completion: { (status, statusCode, message) in
                    completion(status, statusCode, message, nil)
                })
            } else {
                guard let payload = response?.payload else {return}
                completion(true, 200, response?.message ?? "success", payload)
            }
        }
    }
}
