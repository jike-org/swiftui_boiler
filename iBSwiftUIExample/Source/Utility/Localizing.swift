//
//  Localizing.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 21/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

public class Localizing {
    fileprivate func NSLocalizedString(_ key: String) -> String {
        return Foundation.NSLocalizedString(key, comment: "")
    }
}

extension String {
    
    static let Error = NSLocalizedString("Error", comment: "")
    static let Incomplete = NSLocalizedString("Incomplete", comment: "")
    static let Success = NSLocalizedString("Success", comment: "")
    static let Failed = NSLocalizedString("Failed", comment: "")
    
    static let MissingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let NoInternet = NSLocalizedString("Internet connection offline.", comment: "")
    
    static let NameEmpty = NSLocalizedString("Please enter name.", comment: "")
    static let FullNameEmpty = NSLocalizedString("Please enter fullname.", comment: "")
    static let FirstNameEmpty = NSLocalizedString("Please enter firstname.", comment: "")
    static let LastNameEmpty = NSLocalizedString("Please enter lastname.", comment: "")
    static let UsernameEmpty = NSLocalizedString("Please enter username.", comment: "")
    static let EmailEmpty = NSLocalizedString("Please enter email address.", comment: "")
    static let PasswordEmpty = NSLocalizedString("Please enter password.", comment: "")
    static let CountryCodeEmpty = NSLocalizedString("Please enter country code.", comment: "")
    static let PhoneEmpty = NSLocalizedString("Please enter phone number.", comment: "")
    static let CurrentPasswordEmpty = NSLocalizedString("Please enter current password.", comment: "")
    static let NewPasswordEmpty = NSLocalizedString("Please enter new password.", comment: "")
    static let ConfirmPasswordEmpty = NSLocalizedString("Please enter confirm password.", comment: "")
    static let RoleNotSet = NSLocalizedString("Please select role.", comment: "")
    
    static let InvalidUsername = NSLocalizedString("Invalid username.", comment: "")
    static let InvalidEmail = NSLocalizedString("Invalid email address.", comment: "")
    static let InvalidCountryCode = NSLocalizedString("Invalid counrty code.", comment: "")
    static let InvalidPhone = NSLocalizedString("Invalid phone number.", comment: "")
    static let IncompletePhone = NSLocalizedString("Incomplete phone number.", comment: "")
    static let InvalidUrl = NSLocalizedString("Invalid url.", comment: "")
    static let InvalidPassword = NSLocalizedString("Invalid password.", comment: "")
    static let MismatchingPasswords = NSLocalizedString("Passwords do not match.", comment: "")
    static let MismatchingNewPasswords = NSLocalizedString("New Passwords do not match.", comment: "")
    
    static let ShortPassword = NSLocalizedString("Password should be at least \(CharacterCounts.passwordMinimumCharacterCount) characters.", comment: "")
    static let NewAndCurrentPasswordsMatched = NSLocalizedString("Current password and new password can not be same.", comment: "")
    
}
