//
//  File.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-31.
//

import Foundation
import Regex


class Validators {
    
    func nonEmptyValidator(value : String, value2 : String? = nil)-> ValidationStatus {
        if(value.count > 0){
           return .success
        }
        
        return .failure(message: "cannot be empty")
    }
    
    
    func isValidPasswordValidator(value : String, value2 : String? = nil)-> ValidationStatus {
        if(value.count > 7){
           return .success
        }
        
        return .failure(message: "must be 8 digit or more")
    }
    
    
    func confirmPasswordValidator(value : String, value2 : String?)-> ValidationStatus {
        if(value.count < 7){
            return .failure(message: "must be 8 digit or more")
        }
        if(value != value2){
            return .failure(message: "Password mismatch")
        }
        return .success
    }


    func matcherValidator(value : String, value2 : String) -> ValidationStatus {
        let regex : Regex  = value2.r!
        
        guard regex.matches(value) else {
                return .failure(message: "")
            }
        return .success
    }
    
    func isValidEmailValidator(value : String, value2 : String? = nil) -> ValidationStatus {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex : Regex  = pattern.r!
        
        guard regex.matches(value) else {
                return .failure(message: " Invalid email address")
            }
        return .success
    }
    
    
    
}
