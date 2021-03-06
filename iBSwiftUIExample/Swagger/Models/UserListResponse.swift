//
// UserListResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct UserListResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: [User]?
    public var paginator: Paginator?

    public init(message: String?, result: Bool?, payload: [User]?, paginator: Paginator?) {
        self.message = message
        self.result = result
        self.payload = payload
        self.paginator = paginator
    }


}

