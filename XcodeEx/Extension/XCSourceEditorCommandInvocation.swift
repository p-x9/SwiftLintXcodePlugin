//
//  XCSourceEditorCommandInvocation.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2022/02/08.
//  
//

import Foundation
import XcodeKit

extension XCSourceEditorCommandInvocation {
    func selectedLine(at selectionIndex: Int) -> String? {
        guard let lines = self.buffer.lines as? [String],
              let selection = self.buffer.selections[selectionIndex] as? XCSourceTextRange else {
                  return nil
        }

        return (selection.start.line...selection.end.line).map { row -> String in
            let line = lines[row]

            let startIndex = line.index(line.startIndex, offsetBy: 0)
            let endIndex = line.index(line.startIndex, offsetBy: line.count - 1)

            return String(line[startIndex ..< endIndex])
        }.joined(separator: "\n")
    }

    func selectedString(at selectionIndex: Int) -> String? {
        guard let lines = self.buffer.lines as? [String],
              let selection = self.buffer.selections[selectionIndex] as? XCSourceTextRange else {
                  return nil
        }

        return (selection.start.line...selection.end.line).compactMap { row -> String? in
            let line = lines[row]

            let isStartLine = row == selection.start.line
            let isEndLine = row == selection.end.line

            let start = isStartLine ? selection.start.column : 0
            let end = isEndLine ? selection.end.column : line.utf8CString.count - 1

            return line[NSRange(location: start, length: end - start)]
        }.joined()

    }
}
