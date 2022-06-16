//
//  FormValidator.swift
//  Copyright © 2019 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public enum ValidateError: Error {
    case invalidData(String)
}

public enum PasswordStrengthType: Error {
    case free, withUpperCaseLetterOnly, withDigitOnly, withSpecialCharactor, withUpperCaseLetterAndDigit, withUpperCaseLetterDigitAndSpecialCharactor
}

public protocol FormValidatorDelegate {
    
    func isValidEmailAddress(email: String) -> Bool
    func isValidPhoneNumber(phone: String?) -> Bool
    func isValidPassword(password: String) -> Bool
    
    func validateString(_ value: String) -> Bool
    func validateInt(_ value: Int) -> Bool
    func validateDouble(_ value: Double) -> Bool
    
    func validateForm(formItems: [FormParameterItem]) throws -> Bool
}

public class FormValidator: NSObject {
    
    var delegate: FormValidatorDelegate?
    
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
    
    //MARK: This function is used to check the strong password validity
    func isValidPassword(password: String, type: PasswordStrengthType) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$_!%*?&#])[A-Za-z\\dd$@$_!%*?&#]{6,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if passwordTest.evaluate(with: password) {
            return true
        }
        return false
    }
    
    func hadleErrorResponse(_ error: Error?, completion: iBSCompletionHandler) {
        
        if let errorResponse = error as? ErrorResponse {
            switch errorResponse {
            case .error(let statusCode, let data, _):
                guard let responseData = data else {return}
                let errorJson = JSON(responseData)
                completion(false, statusCode, errorJson["message"].stringValue)
            }
        } else {
            completion(false, 422, "Error is corrupted")
        }
    }
}

public extension FormValidator {
    
    func validateString(_ value: String) -> Bool {
        guard (value != "") else {
            return false
        }
        return true
    }
    
    func validateInt(_ value: Int) -> Bool {
        guard (value > 0) else {
            return false
        }
        return true
    }
    
    func validateDouble(_ value: Double) -> Bool {
        guard (value > 0.0) else {
            return false
        }
        return true
    }
}

public extension FormValidator {
    
    //MARK: validation
    func validateForm(formItems: [FormParameterItem]) throws -> Bool {
        
        try! formItems.forEach({ item in
            
            if item.isMandatory {
                
                switch item.itemType {
                case .email:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData("Please enter valid email adress.")
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData("Please enter email address.")
                    }
                    guard isValidEmailAddress(email: value) else {
                        throw ValidateError.invalidData("Please enter valid email adress.")
                    }
                case .username:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData("Please enter valid username.")
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData("Please enter username.")
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().count >= item.minCharacterCount) else {
                        throw ValidateError.invalidData("Please enter valid username.")
                    }
                case .countryCode:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData("Please enter valid country code.")
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData("Please enter country code.")
                    }
                case .phone:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData("Please enter valid phone number.")
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData("Please enter phone number.")
                    }
                case .countryCode_phone:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData("Please enter valid phone number.")
                    }
                    guard !(value.trimLeadingTralingNewlineWhiteSpaces().isEmpty) else {
                        throw ValidateError.invalidData("Please enter phone number.")
                    }
                    guard (value.trimLeadingTralingNewlineWhiteSpaces().components(separatedBy: " ").count >= 2) else {
                        throw ValidateError.invalidData("Please enter phone number with country code.")
                    }
                    guard isValidPhoneNumber(phone: value, minDigitCount: item.minCharacterCount, maxDigitCount: item.maxCharacterCount) else {
                        throw ValidateError.invalidData("Please enter valid phone number.")
                    }
                case .password:
                    guard (item.parameterValue is String), let value = item.parameterValue as? String else {
                        throw ValidateError.invalidData("Please enter valid password.")
                    }
                    guard !(value.isEmpty) else {
                        throw ValidateError.invalidData("Please enter password.")
                    }
                    guard (value.count >= item.characterCount) else {
                        throw ValidateError.invalidData("Please enter valid password.")
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
                            throw ValidateError.invalidData("Please add \(item.itemType.rawValue).")
                        }
                        guard (value != nil) else {
                            throw ValidateError.invalidData("Please add \(item.itemType.rawValue).")
                        }
                    case is Data:
                        guard let value = item.parameterValue as? Data else {
                            throw ValidateError.invalidData("Please add \(item.itemType.rawValue).")
                        }
                        guard (value != nil) else {
                            throw ValidateError.invalidData("Please add \(item.itemType.rawValue).")
                        }
                    case is Date:
                        break
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
                            throw ValidateError.invalidData("Please enter valid email adress.")
                        }
                    }
                case .countryCode_phone:
                    let value = item.parameterValue as? String
                    if !(value?.trimLeadingTralingNewlineWhiteSpaces().isEmpty ?? false) {
                        guard isValidPhoneNumber(phone: value ?? "", minDigitCount: item.minCharacterCount, maxDigitCount: item.maxCharacterCount) else {
                            throw ValidateError.invalidData("Please enter valid phone number.")
                        }
                    }
                default:
                    break
                }
            }
        })
        
        return true
    }
}
