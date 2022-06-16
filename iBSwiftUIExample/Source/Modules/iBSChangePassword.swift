//
//  iBSChangePassword.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSChangePasswordDelegate {
    
    @objc optional func validateChangePassword(completion: iBSActionHandler)
    @objc optional func changePasswordNetworkRequest(completion: @escaping iBSCompletionHandler)
}

public class iBSChangePassword: iBSBase {
    
    public var delegate: iBSChangePasswordDelegate?
    
    public var _initialParams: [String: Any] = [:]
    public var _formItems: [FormParameterItem] = []
    
    
    public init(initialParams: [String: Any], formItems: [FormParameterItem]) {
        _initialParams = initialParams
        _formItems = formItems
    }
    
    //MARK: Validate Change Password
    public func validateChangePassword(completion: iBSActionHandler) {
        do {
            if try validateForm(formItems: _formItems) {
                completion(true, .Success)
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, .MissingData)
        }
    }
    
    
    //MARK: Proceed with Change Password API
    public func changePasswordNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Init change password parameter dictionary
        var changePasswordParameters: [String: Any] = [:]
        
        // Add initial parameters to parameter dictionary
        changePasswordParameters.updateParameterDictionary(values: _initialParams)
        
        // Add other parameters to parameter dictionary
        _formItems.forEach({ item in
            changePasswordParameters.updateParameterDictionary(values: [item.parameterKey: item.parameterValue as Any])
        })
        
        // Remove null value keys from parameter dictionary
        changePasswordParameters = changePasswordParameters.removeNullKeysFromParameterDictionary()
        
        // Change Password web service call
        AuthAPI.passwordEditPost(body: changePasswordParameters) { (response, error) in
            
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
