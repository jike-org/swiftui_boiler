//
//  iBSOTP.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 23/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSVerifyOTPDelegate {
    
    @objc optional func validateAndCheckOTP(completion: iBSActionHandler)
    @objc optional func validateOTPNetworkRequest(completion: @escaping iBSCompletionHandlerWithData)
}

public class iBSVerifyOTP: iBSBase {
    
    public var delegate: iBSVerifyOTPDelegate?
    
    public var _initialParams: [String: Any] = [:]
    public var _formItems: [FormParameterItem] = []
    
    
    public init(initialParams: [String: Any], formItems: [FormParameterItem]) {
        _initialParams = initialParams
        _formItems = formItems
    }

    //MARK: Validate and Check OTP
    public func validateVerifyOTP(completion: iBSActionHandler) {
        do {
            if try validateForm(formItems: _formItems) {
                completion(true, "Success")
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, "Mising data")
        }
    }

    //MARK: Proceed with Verify OTP API
    public func validateOTPNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Init veryfy OTP parameter dictionary
        var verifyOTPParameters: [String: Any] = [:]
        
        // Add initial parameters to parameter dictionary
        verifyOTPParameters.updateParameterDictionary(values: _initialParams)
        
        // Add other parameters to parameter dictionary
        _formItems.forEach({ item in
            verifyOTPParameters.updateParameterDictionary(values: [item.parameterKey: item.parameterValue as Any])
        })
        
        // Remove null value keys from parameter dictionary
        verifyOTPParameters = verifyOTPParameters.removeNullKeysFromParameterDictionary()
        
        
        // Verify OTP web service call
        /*AuthAPI.verifyOTPPost(body: verifyOTPParameters) { (response, error) in
            
            if error != nil {
                // Handle error
                self.hadleErrorResponse(error, completion: { (status, statusCode, message) in
                    completion(status, statusCode, message, nil)
                })
            } else {
                guard let payload = response?.payload else {return}
                completion(true, 200, response?.message ?? "success", payload)
            }
        }*/
    }
}
