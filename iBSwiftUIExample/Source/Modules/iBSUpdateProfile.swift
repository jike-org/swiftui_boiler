//
//  iBSUpdateProfile.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol iBSUpdateProfileDelegate {
    
    @objc optional func validateUpdateProfile(completion: iBSActionHandler)
    @objc optional func updateProfileInfoNetworkRequest(completion: @escaping iBSCompletionHandlerWithData)
    @objc optional func updateProfilePictureNetworkRequest(url: URL, completion: @escaping iBSCompletionHandlerWithData)
}

public class iBSUpdateProfile: iBSBase {
    
    public var delegate: iBSUpdateProfileDelegate?
    
    public var _initialParams: [String: Any] = [:]
    public var _formItems: [FormParameterItem] = []
    
    
    public init(initialParams: [String: Any], formItems: [FormParameterItem]) {
        _initialParams = initialParams
        _formItems = formItems
    }
    
    //MARK: Validate Update Profile Info
    public func validateUpdateProfile(completion: iBSActionHandler) {
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
    
    
    //MARK: Proceed with Update Profile Info API
    public func updateProfileInfoNetworkRequest(completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Init update profile parameter dictionary
        var updateProfileParameters: [String: Any] = [:]
        
        // Add initial parameters to parameter dictionary
        updateProfileParameters.updateParameterDictionary(values: _initialParams)
        
        // Add other parameters to parameter dictionary
        _formItems.forEach({ item in
            updateProfileParameters.updateParameterDictionary(values: [item.parameterKey: item.parameterValue as Any])
        })
        
        // Remove null value keys from parameter dictionary
        updateProfileParameters = updateProfileParameters.removeNullKeysFromParameterDictionary()
        
        // Update Profile Info web service call
        ProfileAPI.profilePut(body: updateProfileParameters) { (response, error) in
            
            if error != nil {
                //handle error
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
    
    
    //MARK: Proceed with Update Profile Picture API
    public func updateProfilePictureNetworkRequest(url: URL, completion: @escaping iBSCompletionHandlerWithData) {
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            completion(false, 503, .NoInternet, nil)
            return
        }
        
        // Update Profile Picture Update web service call
        ProfileAPI.avatarPost(image: url) { (response, error) in
            
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
