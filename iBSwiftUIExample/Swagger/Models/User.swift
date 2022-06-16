//
// User.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct User: Codable {
    public var _id: String?
    public var uuid: String?
    public var firstName: String?
    public var lastName: String?
    public var fullName: String?
    public var email: String?
    public var avatarUrl: String?
    public var timezone: String?
    public var accessToken: String?
    public var userRole: UserRole.RawValue?

    public init(_id: String?, uuid: String?, firstName: String?, lastName: String?, fullName: String?, email: String?, avatarUrl: String?, timezone: String?, accessToken: String?, userRole : UserRole?) {
        self._id = _id
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.email = email
        self.avatarUrl = avatarUrl
        self.timezone = timezone
        self.accessToken = accessToken
        self.userRole = userRole?.rawValue
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case uuid
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case email
        case avatarUrl = "avatar_url"
        case timezone
        case accessToken = "access_token"
        case userRole = "userRole"
    }


}

public enum UserRole : String{
    case Normal = "Normal"
    case Guest = "Guest"
}