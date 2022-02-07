//
//  SourceEditorCommand.swift
//  SwiftLintPlugin
//
//  Created by p-x9 on 2021/05/22.
//  
//

import Foundation
import XcodeKit
import Defaults

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    class var commandIdentifier: String {
        let bundleID = Bundle.main.bundleIdentifier ?? "com.p-x9.SwiftLintPlugin.XcodeEx"
        return bundleID + "." + className()
    }

    class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "",
            .classNameKey: className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {}

}
