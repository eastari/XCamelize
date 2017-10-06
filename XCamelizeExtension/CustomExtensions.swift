//
//  CustomExtensions.swift
//  XCamelize
//
//  Created by Starikov Yevgen on 25/07/2017.
//  Copyright © 2017 Starikov Yevgen. All rights reserved.
//

import Foundation

public extension String {
    
    func camelize() -> String {
        
        let source = removeFirstSpaces(clean(with: " ", allOf: "-", "_", "."))
        
        if source.characters.contains(" ") {
            let first = source[self.startIndex...self.index(after: startIndex)].lowercased()
            let cammel = source.capitalized.replacingOccurrences(of: " ", with: "")
            let rest = String(cammel.characters.dropFirst())
            
            
            return "\(first.characters.first ?? self[self.startIndex])\(rest)"
        } else {
            let first = source[self.startIndex...self.index(after: startIndex)].lowercased()
            let rest = String(source.characters.dropFirst()).lowercased()
            return "\(first.characters.first ?? self[self.startIndex])\(rest)"
        }
    }
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    func removeFirstSpaces(_ str: String) -> String {
        var stringArr = str.characters
        var i = 0
        for char in self.characters {
            if char == " " || char == "/"{
                stringArr = stringArr.dropFirst()
            } else {
                break
            }
            i += 1
        }
        return String(stringArr)
    }
    
}
