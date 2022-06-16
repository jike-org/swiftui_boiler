//
// SettingsGetSettingsResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SettingsGetSettingsResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: [Setting]?

    public init(message: String?, result: Bool?, payload: [Setting]?) {
        self.message = message
        self.result = result
        self.payload = payload
    }


}

