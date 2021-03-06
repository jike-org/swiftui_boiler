//
// SettingsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class SettingsAPI {
    /**
     Get Settings
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func settingsGet(completion: @escaping ((_ data: SettingsGetSettingsResponse?,_ error: Error?) -> Void)) {
        settingsGetWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get Settings
     - GET /settings
     - Returns all app settings. Each setting value is identified by the respective key.
     - API Key:
       - type: apiKey x-api-key 
       - name: apiKey
     - examples: [{contentType=application/json, example={
  "result" : true,
  "payload" : {
    "TERMS_AND_CONDITIONS" : "TERMS_AND_CONDITIONS",
    "PRIVACY_POLICY" : "PRIVACY_POLICY",
    "ABOUT_US" : "ABOUT_US"
  },
  "message" : "message"
}}]

     - returns: RequestBuilder<SettingsGetSettingsResponse> 
     */
    open class func settingsGetWithRequestBuilder() -> RequestBuilder<SettingsGetSettingsResponse> {
        let path = "/settings"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<SettingsGetSettingsResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get Setting
     
     - parameter key: (path) Key of the setting 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func settingsKeyGet(key: String, completion: @escaping ((_ data: SettingsGetSettingResponse?,_ error: Error?) -> Void)) {
        settingsKeyGetWithRequestBuilder(key: key).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get Setting
     - GET /settings/{key}
     - Returns the value of a single app setting requested by key.
     - API Key:
       - type: apiKey x-access-token 
       - name: accessToken
     - API Key:
       - type: apiKey x-api-key 
       - name: apiKey
     - examples: [{contentType=application/json, example={
  "result" : true,
  "payload" : "{}",
  "message" : "message"
}}]
     
     - parameter key: (path) Key of the setting 

     - returns: RequestBuilder<SuccessResponse> 
     */
    open class func settingsKeyGetWithRequestBuilder(key: String) -> RequestBuilder<SettingsGetSettingResponse> {
        var path = "/settings/{key}"
        let keyPreEscape = "\(key)"
        let keyPostEscape = keyPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{key}", with: keyPostEscape, options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<SettingsGetSettingResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
