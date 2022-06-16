//
//  Constant.swift
//  Copyright © 2019 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    //MARK: Manage app environment with release type
    static let appEnvironment: DeploymentEnvironment = .development
    
    //MARK: App environments
    enum DeploymentEnvironment {
        case development
        case staging
        case production
    }
    
    //MARK: Get URLs (Base url etc.)
    enum URLs {
        static let baseUrl = getBaseURL()
    }
    
    //MARK: Provide base url for current app environment
    static func getBaseURL() -> String {
        switch Constant.appEnvironment {
        case .development:
            return "https://oxygen.sandbox15.preview.cx/api/v1"
        case .staging:
            return ""
        case .production:
            return "https://"
        }
    }
    
    
    //MARK: Get API keys
    enum APIKeys {
        static let RESTful = Constant.getAPIKey()
        static let google = "AIzaSyDvhCb4KV0JGovYCExaJVAjQYbylqmyQ5k" //"AIzaSyAWBpYdXWTp0OzIvSNIB08d3414nYvA3Pc"
    }
    
    //MARK: Provide API key for current app environment
    static func getAPIKey() -> String {
        switch Constant.appEnvironment {
        case .development:
            return "cXRZWOedaKl2QIdUsfAie4bW8jdFB3Fib1FE/dvznJM="
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
    
    //MARK: Character counts
    enum Counts {
        static let passwordCount = 8
        static let nameMinimumCharCount = 2
    }
    
    //MARK: Static contents
    enum AppDetails {
        static let termsUrl = "https://www.elegantmedia.com.au/"
        static let privacyUrl = "https://www.elegantmedia.com.au/privacy-policy/"
        static let aboutUrl = "https://www.elegantmedia.com.au/about-us/"
    }
}
