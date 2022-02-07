//
//  String.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2022/02/08.
//  
//

import Foundation

extension String {
    subscript(nsrange: NSRange) -> String? {
        guard nsrange.location != NSNotFound else {
            return nil
        }
        let start = utf16.index(utf16.startIndex, offsetBy: nsrange.location,
                                limitedBy: utf16.endIndex) ?? utf16.endIndex
        let end = utf16.index(start, offsetBy: nsrange.length,
                              limitedBy: utf16.endIndex) ?? utf16.endIndex

        guard let startIndex = Index(start, within: self),
              let endIndex = Index(end, within: self) else {
                  return nil
              }

        return String(self[startIndex..<endIndex])
    }
}
