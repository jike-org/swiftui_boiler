//
//  iBSUserDefaults.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 3/2/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation

public struct iBSUserDefaults {
    
    public static let shared = UserDefaults.standard
    
    //MARK: Set FCM token
    public static func setFCMToken(token: String) {
        shared.set(token, forKey: "FCM_TOKEN")
        shared.synchronize()
    }
    
    //MARK: Get FCM token
    public static func getFCMToken() -> String {
        if let token = shared.string(forKey: "FCM_TOKEN") {
            return token
        }
        return ""
    }
    
    //MARK: Set access token
    public static func setAccessToken(token: String) {
        shared.set(token, forKey: "ACCESS_TOKEN")
        shared.synchronize()
    }
    
    //MARK: Get access token
    public static func getAccessToken() -> String {
        if let token = shared.string(forKey: "ACCESS_TOKEN") {
            return token
        }
        return ""
    }
    
    //MARK: Remove access token
    public static func removeAccessToken() {
        shared.object(forKey: "ACCESS_TOKEN")
        shared.synchronize()
    }
}
