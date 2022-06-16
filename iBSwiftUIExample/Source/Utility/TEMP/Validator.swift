//
//  Validator.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 1/2/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

public class Validator {
    
    //MARK: Validate String
    func validateString(value: String, with rules: [StringRule]) -> String? {
        return rules.compactMap({ $0.checkString(value) }).first
    }

    func validateString(input: FormParameterItem, with rules: [StringRule]) {
        guard (input.parameterValue is String), let value = input.parameterValue as? String else {
            return
        }
        
        guard let message = validateString(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    
    //MARK: Validate Int
    func validateInt(value: Int, with rules: [IntRule]) -> String? {
        return rules.compactMap({ $0.checkInt(value) }).first
    }
    
    func validateInt(input: FormParameterItem, with rules: [IntRule]) {
        guard (input.parameterValue is Int), let value = input.parameterValue as? Int else {
            return
        }
        
        guard let message = validateInt(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    
    //MARK: Validate Double
    func validateDouble(value: Double, with rules: [DoubleRule]) -> String? {
        return rules.compactMap({ $0.checkDouble(value) }).first
    }
    
    func validateDouble(input: FormParameterItem, with rules: [DoubleRule]) {
        guard (input.parameterValue is Double), let value = input.parameterValue as? Double else {
            return
        }
        
        guard let message = validateDouble(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    //MARK: Validate Bool
    func validateBool(value: Bool, with rules: [BoolRule]) -> String? {
        return rules.compactMap({ $0.checkBool(value) }).first
    }
    
    func validateBool(input: FormParameterItem, with rules: [BoolRule]) {
        guard (input.parameterValue is Bool), let value = input.parameterValue as? Bool else {
            return
        }
        
        guard let message = validateBool(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    //MARK: Validate URL
    func validateURL(value: URL, with rules: [URLRule]) -> String? {
        return rules.compactMap({ $0.checkURL(value) }).first
    }
    
    func validateURL(input: FormParameterItem, with rules: [URLRule]) {
        guard (input.parameterValue is URL), let value = input.parameterValue as? URL else {
            return
        }
        
        guard let message = validateURL(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    //MARK: Validate Bool
    func validateData(value: Data, with rules: [DataRule]) -> String? {
        return rules.compactMap({ $0.checkData(value) }).first
    }
    
    func validateData(input: FormParameterItem, with rules: [DataRule]) {
        guard (input.parameterValue is Data), let value = input.parameterValue as? Data else {
            return
        }
        
        guard let message = validateData(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    //MARK: Validate Array
    func validateArray(value: NSArray, with rules: [ArrayRule]) -> String? {
        return rules.compactMap({ $0.checkArray(value) }).first
    }
    
    func validateArray(input: FormParameterItem, with rules: [ArrayRule]) {
        guard (input.parameterValue is NSArray), let value = input.parameterValue as? NSArray else {
            return
        }
        
        guard let message = validateArray(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
    
    
    //MARK: Validate Dictionary
    func validateDictionary(value: NSDictionary, with rules: [DictionaryRule]) -> String? {
        return rules.compactMap({ $0.checkDictionary(value) }).first
    }
    
    func validateDictionary(input: FormParameterItem, with rules: [DictionaryRule]) {
        guard (input.parameterValue is NSDictionary), let value = input.parameterValue as? NSDictionary else {
            return
        }
        
        guard let message = validateDictionary(value: value, with: rules) else {
            //input.message?.messageLabel.isHidden = true
            return
        }

        //input.message?.messageLabel.isHidden = false
        //input.message?.messageLabel.text = message
    }
}
