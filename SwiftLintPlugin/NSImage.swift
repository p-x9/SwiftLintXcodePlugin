//
//  NSImage.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2022/02/11.
//  
//

import Cocoa

extension NSImage {
    func withTintColor(_ tintColor: NSColor) -> NSImage {
        if self.isTemplate == false {
            return self
        }

        let image = self.copy() as! NSImage
        image.lockFocus()

        tintColor.set()
        __NSRectFillUsingOperation(NSRect(origin: .zero, size: image.size), .sourceAtop)

        image.unlockFocus()
        image.isTemplate = false

        return image
    }
}
