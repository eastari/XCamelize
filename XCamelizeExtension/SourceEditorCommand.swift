//
//  SourceEditorCommand.swift
//  XCamelizeExtension
//
//  Created by Starikov Yevgen on 25/07/2017.
//  Copyright © 2017 Starikov Yevgen. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Swift.Void ) {
        
        let buffer = invocation.buffer
        let selections = buffer.selections
        
        selections.forEach {
            let range = $0 as! XCSourceTextRange

            if range.start.line != range.end.line {

                // Return error if 2 or more lines
                let error = NSError(domain: "Please, select one line ! ", code: 1, userInfo: nil)
                completionHandler(error)
                
            } else {
                
                handle(range: range, inBuffer: buffer)
            }
        }
        
        completionHandler(nil)
    }
    
    func handle(range: XCSourceTextRange, inBuffer buffer: XCSourceTextBuffer) -> () {
        let selectedText = getTextFromBuffer(inRange: range, inBuffer: buffer)
        let textCamelize = selectedText.camelize() + " "
        let selectedTextLength = selectedText.characters.count

        replace(position: range.start, length: selectedTextLength, with: textCamelize, inBuffer: buffer)

        // Fix selection after replace
        offsetSelection(range, by: 0)

    }
    
    func getTextFromBuffer(inRange textRange: XCSourceTextRange, inBuffer buffer: XCSourceTextBuffer) -> String {
        if textRange.start.line == textRange.end.line {
            let lineText = buffer.lines[textRange.start.line] as! String
            let from = lineText.index(lineText.startIndex, offsetBy: textRange.start.column)
            let to = lineText.index(lineText.startIndex, offsetBy: textRange.end.column)
            return lineText[from...to]
        }
        
        var text = ""
        
        for aLine in textRange.start.line...textRange.end.line {
            let lineText = buffer.lines[aLine] as! String
            
            switch aLine {
            case textRange.start.line:
                text += lineText.substring(from: lineText.index(lineText.startIndex, offsetBy: textRange.start.column))
            case textRange.end.line:
                text += lineText.substring(to: lineText.index(lineText.startIndex, offsetBy: textRange.end.column + 1))
            default:
                text += lineText
            }
        }
        
        return text
    }
    
    func replace(position: XCSourceTextPosition, length: Int, with newElements: String, inBuffer buffer: XCSourceTextBuffer) {
        var lineText = buffer.lines[position.line] as! String
        
        var start = lineText.index(lineText.startIndex, offsetBy: position.column)
        var end = lineText.index(start, offsetBy: length)
        
        if length < 0 {
            swap(&start, &end)
        }
        
        lineText.replaceSubrange(start..<end, with: newElements)
        lineText.remove(at: lineText.index(before: lineText.endIndex)) //remove end "\n"
        
        buffer.lines[position.line] = lineText
    }
    
    
    func offsetSelection(_ selection: XCSourceTextRange, by offset: Int) {
        selection.end.column += offset
    }
    
}
