//
//  FormItem.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 19/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import UIKit

public struct FormParameterItem {
    
    public var itemType: FormItemType
    public var parameterKey: String
    public var parameterValue: Any?
    public var comparingValue: Any?
    public var characterCount: Int = 0
    public var minCharacterCount: Int = 0
    public var maxCharacterCount: Int = 0
    public var isMandatory: Bool = false
    public var nextItemType: FormItemType? = nil
    
    public init(itemType: FormItemType, parameterKey: String, parameterValue: Any?, comparingValue: Any?, characterCount: Int, minCharacterCount: Int, maxCharacterCount: Int, isMandatory: Bool, nextItemType: FormItemType?) {
        
        self.itemType = itemType
        self.parameterKey = parameterKey
        self.parameterValue = parameterValue
        self.comparingValue = comparingValue
        self.characterCount = characterCount
        self.minCharacterCount = minCharacterCount
        self.maxCharacterCount = maxCharacterCount
        self.isMandatory = isMandatory
        self.nextItemType = nextItemType
    }
}

public enum FormItemType: String {
    case idInt, idString, userRoleInt, userRoleString, firstName, lastName, name, fullName, username, email, otpCode, countryCode, phone, countryCode_phone, address, city, suburb, state, country, zipCode, countryISOCode, latitude, longitude, timezone, dob, _info, summary, _description, about, bio, company, password, confirmPassword, newPassword, confirmNewPassword, other
}
