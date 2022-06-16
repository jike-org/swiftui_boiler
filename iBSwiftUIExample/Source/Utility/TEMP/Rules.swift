//
//  Rules.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 1/2/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

public struct StringRule {
    // Return nil if matches, error message otherwise
    let checkString: (String) -> String?

    static let notEmpty = StringRule(checkString: {
        return $0.isEmpty ? "Must not be empty" : nil
    })

    static let validEmail = StringRule(checkString: {
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "Must have valid email"
    })

    static let countryCode = StringRule(checkString: {
        let regex = #"^\+\d+.*"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "Must have prefix country code"
    })
}

public struct IntRule {
    // Return nil if matches, error message otherwise
    let checkInt: (Int) -> String?
    
    static let notZero = IntRule(checkInt: {
        return $0 != 0 ? "Must not be zero" : nil
    })
    
    static let greaterThanZero = IntRule(checkInt: {
        return $0 > 0 ? "Must be greater than zero" : nil
    })
    
    static let lesserThanZero = IntRule(checkInt: {
        return $0 < 0 ? "Must be lesser than zero" : nil
    })
}

public struct DoubleRule {
    // Return nil if matches, error message otherwise
    let checkDouble: (Double) -> String?
    
    static let notZero = DoubleRule(checkDouble: {
        return $0 != 0.0 ? "Must not be zero" : nil
    })
    
    static let greaterThanZero = DoubleRule(checkDouble: {
        return $0 > 0.0 ? "Must be greater than zero" : nil
    })
    
    static let lesserThanZero = DoubleRule(checkDouble: {
        return $0 < 0.0 ? "Must be lesser than zero" : nil
    })
}

public struct BoolRule {
    // Return nil if matches, error message otherwise
    let checkBool: (Bool) -> String?
    
    static let haveValue = BoolRule(checkBool: {
        return ($0 == false || $0 == true) ? "Must not be zero" : nil
    })
    
    static let notFalse = BoolRule(checkBool: {
        return $0 != false ? "Must be true" : nil
    })
    
    static let notTrue = BoolRule(checkBool: {
        return $0 != true ? "Must be false" : nil
    })
}

public struct URLRule {
    // Return nil if matches, error message otherwise
    let checkURL: (URL?) -> String?
    
    static let isUrl = URLRule(checkURL: {
        return $0 != nil ? "Must be valid URL" : nil
    })
}

public struct DataRule {
    // Return nil if matches, error message otherwise
    let checkData: (Data?) -> String?
    
    static let hasData = DataRule(checkData: {
        return $0 != nil ? "Must be valid data" : nil
    })
}

public struct ArrayRule {
    // Return nil if matches, error message otherwise
    let checkArray: (NSArray) -> String?
    
    static let notEmpty = ArrayRule(checkArray: {
        return $0.count > 0 ? "Must include values" : nil
    })
}

public struct DictionaryRule {
    // Return nil if matches, error message otherwise
    let checkDictionary: (NSDictionary) -> String?
    
    static let notEmpty = DictionaryRule(checkDictionary: {
        return $0.allValues.count > 0 ? "Must include values" : nil
    })
}
