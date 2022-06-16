//
//  AppExtensions.swift
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation

public extension String {

    func trimLeadingTralingNewlineWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func removingAllWhitespaces() -> String {
        return removingCharacters(from: .whitespaces)
    }

    func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
}

public extension Dictionary {
    
    // To Update Parameter dictionary
    mutating func updateParameterDictionary(values: Dictionary) {
        for (key, value) in values {
            self.updateValue(value, forKey: key)
        }
    }
    
    func removeNullKeysFromParameterDictionary() -> Dictionary {
        var dict = self
        let keysToRemove = Array(dict.keys).filter { dict[$0] is NSNull }
        for key in keysToRemove {
            dict.removeValue(forKey: key)
        }
        return dict
    }
    
    func removeNullZeroEmptyKeysFromParameterDictionary() -> Dictionary {
        var dict = self
        let keysToRemove = Array(dict.keys).filter { dict[$0] is NSNull || ((dict[$0] as? Int) == 0) || ((dict[$0] as? String) == "") }
        for key in keysToRemove {
            dict.removeValue(forKey: key)
        }
        return dict
    }
}
