//
//  iBSLogin.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSLoginDelegate {
    
    @objc optional func validateLoginUser(completion: iBSActionHandler)
    @objc optional func userLoginNetworkRequest(completion: @escaping iBSCompletionHandlerWithData)
}

public class iBSLogin: iBSBase {
    
    public var delegate: iBSLoginDelegate?
    
    public var _initialParams: [String: Any] = [:]
    public var _formItems: [FormParameterItem] = []
    
    
    public init(initialParams: [String: Any], formItems: [FormParameterItem]) {
        _initialParams = initialParams
        _formItems = formItems
    }
    
    
    //MARK: Validate Login User
    public func validateLoginUser(completion: iBSActionHandler) {
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
    
    
    //MARK: Proceed with Login User API
    public func userLoginNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Init login parameter dictionary
        var loginParameters: [String: Any] = [:]
        
        // Add initial parameters to parameter dictionary
        loginParameters.updateParameterDictionary(values: _initialParams)
        
        // Add other parameters to parameter dictionary
        _formItems.forEach({ item in
            loginParameters.updateParameterDictionary(values: [item.parameterKey: item.parameterValue as Any])
        })
        
        // Remove null value keys from parameter dictionary
        loginParameters = loginParameters.removeNullKeysFromParameterDictionary()
        
        // Login web service call
        AuthAPI.loginPost(body: loginParameters) { (response, error) in
            
            if error != nil {
                // Handle error
                self.hadleErrorResponse(error, completion: { (status, statusCode, message) in
                    completion(status, statusCode, message, nil)
                })
            } else {
                guard let payload = response?.payload else {return}
                
                // Get payload as readable object
                let payloadDictionary: PayloadDictionary = (payload.value as? PayloadDictionary) ?? [:]
                
                // Read access token from readable object
                let accessToken: String = (payloadDictionary["access_token"]) as? String ?? ""
                
                // Set access token to user defaults
                iBSUserDefaults.setAccessToken(token: accessToken)
                
                // Set access token to custom headers at SwaggerAPIClient
                AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
                
                completion(true, 200, response?.message ?? "success", payloadDictionary)
            }
        }
    }
}
