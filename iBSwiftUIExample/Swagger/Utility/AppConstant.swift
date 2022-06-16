//
//  Constant.swift
//  Copyright © 2019 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

public class AppConstant {
    
    //MARK: Base URL
    public static var baseURL: String = ""
    
    //MARK: RESTful API key
    public static var RESTfulAPIKey: String = ""
    
    //MARK: Google API key
    public static var googleAPIKey: String = ""
    
    //MARK: Custom headers
    public static var customHeaders: [String: String] = [:]
    
    //MARK: Get Updated Custom headers
    public static func getCustomHeaders() -> [String: String] {
        
        customHeaders = ["x-api-key": RESTfulAPIKey, "Accept" : "application/json"]
        
        // Check access token exits
        let accessToken = iBSUserDefaults.getAccessToken()
        
        if !(accessToken.isEmpty) {
            // Add access token to current custom headers
            customHeaders.updateValue(accessToken, forKey: "x-access-token")
        }
        
        return customHeaders
    }
    
    //MARK: Add access token to SwaggerAPIClient Custom headers
    public static func addAccessTokenToSwaggerAPIClientcustomHeaders() {
        
        // Check access token exits
        let accessToken = iBSUserDefaults.getAccessToken()
        
        if !(accessToken.isEmpty) {
            // Add access token to current custom headers
            SwaggerClientAPI.customHeaders.updateValue(accessToken, forKey: "x-access-token")
        }
    }
    
}
