//
//  iBSBase.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 1/2/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

open class iBSBase: NSObject {
    
    //MARK: This function is used to check the email address validity
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: email) {
            return true
        }
        return false
    }
    
    //MARK: This function is used to check the phone number validity
    func isValidPhoneNumber(phone: String?, minDigitCount: Int, maxDigitCount: Int) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phone?.components(separatedBy: charcterSet)
        let filtered = inputString?.joined(separator: "")
        return (phone == filtered) && ((filtered!.count) > minDigitCount) && ((filtered!.count) < maxDigitCount)
    }

    func hadleErrorResponse(_ error: Error?, completion: iBSCompletionHandler) {
        if let errorResponse = error as? ErrorResponse {
            switch errorResponse {
            case .error(let statusCode, let data, let error):
                if let responseData = data {
                    let errorJson = JSON(responseData)
                    
                    if let message = errorJson["message"].string {
                        print("error: \(message), code: \(statusCode)")
                        completion(false, statusCode, message)
                    } else {
                        print("error: \(error.localizedDescription) , code: \(statusCode)")
                        completion(false, statusCode, error.localizedDescription)
                    }
                } else if let errorResponse = error as? AFError {
                    switch errorResponse {
                    case .invalidURL(let url):
                        print("Error in URL: \(url)")
                        completion(false, errorResponse.responseCode ?? 500, errorResponse.errorDescription ?? errorResponse.localizedDescription)
                    default:
                        print("error: \(errorResponse.errorDescription ?? errorResponse.localizedDescription), code: \(statusCode)")
                        completion(false, errorResponse.responseCode ?? 500, errorResponse.errorDescription ?? errorResponse.localizedDescription)
                    }
                }
            }
        } else if let errorResponse = error as? DecodingError {
            switch errorResponse {
            case .typeMismatch(let type, let context):
                print("Type '\(type)' mismatch: \(context.codingPath)" )
                completion(false, 422, context.debugDescription)
            default:
                completion(false, 422, error?.localizedDescription ?? "Error is corrupted")
            }
        }
    }
    
    func validateForm(formItems: [FormParameterItem]) throws -> Bool {
        
        for item in formItems {
            
            if item.isMandatory {
                
                switch item.itemType {
                case .email:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData(.InvalidEmail)
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData(.EmailEmpty)
                    }
                    guard isValidEmailAddress(email: value) else {
                        throw ValidateError.invalidData(.InvalidEmail)
                    }
                case .username:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData(.InvalidUsername)
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData(.UsernameEmpty)
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().count >= item.minCharacterCount) else {
                        throw ValidateError.invalidData(.InvalidUsername)
                    }
                case .countryCode:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData(.InvalidCountryCode)
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData(.CountryCodeEmpty)
                    }
                case .countryCode_phone:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData(.InvalidPhone)
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData(.PhoneEmpty)
                    }
                    guard (value.trimLeadingTralingNewlineWhiteSpaces().components(separatedBy: " ").count >= 2) else {
                        throw ValidateError.invalidData(.IncompletePhone)
                    }
                    guard isValidPhoneNumber(phone: value, minDigitCount: item.minCharacterCount, maxDigitCount: item.maxCharacterCount) else {
                        throw ValidateError.invalidData(.InvalidPhone)
                    }
                case .password:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData(.InvalidPassword)
                    }
                    guard !(value.isEmpty) else {
                        throw ValidateError.invalidData(.PasswordEmpty)
                    }
                    guard (value.count >= item.characterCount) else {
                        throw ValidateError.invalidData(.ShortPassword)
                    }
                case .confirmPassword, .confirmNewPassword:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String, let comparingValue = item.comparingValue as? String else {
                        throw ValidateError.invalidData(.MismatchingPasswords)
                    }
                    guard !(value.isEmpty) else {
                        throw ValidateError.invalidData(.ConfirmPasswordEmpty)
                    }
                    guard (value.count >= item.characterCount) else {
                        throw ValidateError.invalidData(.ShortPassword)
                    }
                    guard (value == comparingValue) else {
                        throw ValidateError.invalidData(.MismatchingPasswords)
                    }
                default:
                    switch item.parameterValue {
                    case is String:
                        guard let value = item.parameterValue as? String else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                        guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                    case is Int:
                        guard let value = item.parameterValue as? Int else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                    case is Double:
                        switch item.itemType {
                        case .latitude, .longitude:
                            guard let value = item.parameterValue as? Double else {
                                throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                            }
                            guard (value != nil) else {
                                throw ValidateError.invalidData("Error on finding location data.")
                            }
                        default:
                            break
                        }
                    case is Float:
                        break
                    case is Bool:
                        guard let value = item.parameterValue as? Bool else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                        guard (value != nil) else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                    case is Data:
                        guard let value = item.parameterValue as? Data else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                        guard (value != nil) else {
                            throw ValidateError.invalidData("Please enter \(item.itemType.rawValue).")
                        }
                    default:
                        break
                    }
                }
            } else {
                // Handle is any filed is not mandatory but if filled check is valid
                switch item.itemType {
                case .email:
                    let value = item.parameterValue as? String
                    if !(value?.trimLeadingTralingNewlineWhiteSpaces().isEmpty ?? false) {
                        guard isValidEmailAddress(email: value ?? "") else {
                            throw ValidateError.invalidData(.InvalidEmail)
                        }
                    }
                case .countryCode_phone:
                    let value = item.parameterValue as? String
                    if !(value?.trimLeadingTralingNewlineWhiteSpaces().isEmpty ?? false) {
                        guard isValidPhoneNumber(phone: value ?? "", minDigitCount: item.minCharacterCount, maxDigitCount: item.maxCharacterCount) else {
                            throw ValidateError.invalidData(.InvalidPhone)
                        }
                    }
                default:
                    break
                }
            }
        }
        
        return true
    }
}
