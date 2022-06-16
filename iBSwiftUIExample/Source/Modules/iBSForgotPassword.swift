//
//  iBSForgotPassword.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSForgotPasswordDelegate {
    
    @objc optional func validateRetrivePassword(completion: iBSActionHandler)
    @objc optional func retrivePasswordNetworkRequest(completion: @escaping iBSCompletionHandlerWithData)
}

public class iBSForgotPassword: iBSBase {
    
    public var delegate: iBSForgotPasswordDelegate?
    
    public var _initialParams: [String: Any] = [:]
    public var _formItems: [FormParameterItem] = []
    
    
    public init(initialParams: [String: Any], formItems: [FormParameterItem]) {
        _initialParams = initialParams
        _formItems = formItems
    }
    
    //MARK: Validate Retrive Password
    public func validateRetrivePassword(completion: iBSActionHandler) {
        do {
            if try validateForm(formItems: _formItems) {
                completion(true, .Success)
            } else {
                completion(false, .Failed)
            }
        } catch ValidateError.invalidData(let message) {
            completion(false, message)
        } catch {
            completion(false, .MissingData)
        }
    }
    
    
    //MARK: Proceed with Retrive Password API
    public func retrivePasswordNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Init retrive password parameter dictionary
        var retrivePasswordParameters: [String: Any] = [:]
        
        // Add initial parameters to parameter dictionary
        retrivePasswordParameters.updateParameterDictionary(values: _initialParams)
        
        // Add other parameters to parameter dictionary
        _formItems.forEach({ item in
            retrivePasswordParameters.updateParameterDictionary(values: [item.parameterKey: item.parameterValue as Any])
        })
        
        // Remove null value keys from parameter dictionary
        retrivePasswordParameters = retrivePasswordParameters.removeNullKeysFromParameterDictionary()
        
        // Retrive Password web service call
        ForgotPasswordAPI.passwordEmailPost(body: retrivePasswordParameters) { (response, error) in
            
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
